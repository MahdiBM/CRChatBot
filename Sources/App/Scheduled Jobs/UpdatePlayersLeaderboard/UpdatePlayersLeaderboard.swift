import Vapor
import Queues
import Redis

private typealias Leaderboard = DTOs.Protobuf.ScheduleLeaderboard
private typealias Regions = DataSet.Regions

/*
 This schedule is run all the time, as of now approximately 2.5 times
 per second. The schedule adds new players to the redis database.
 We can then use these players' info to provide services such as
 searching for players' decks who don't have enough trophies to
 get into the top 1000 global leaderboard.
 (Top 1000 global leaderboard can be retrieved from CRAPI, so for players
 who are in top 1K, we can always request more-accurate data from CRAPI).
 This schedule's data take time to retrieve and can get out-dated
 very fast (~3 min), thats why it is run so many times.
 */
struct UpdatePlayersLeaderboard: ScheduledJob {
    /*
     This schedule is called multiple times to speed up the the process,
     these below 3 variables are used to indicate what region's info
     this instance of `UpdatePlayersLeaderboard` is supposed to search for,
     with help of the `calculateRegionIndex()` function.
     */
    
    /// The index of this instance in between all of the schedules
    /// which were called simultaneously alongside this instance.
    var scheduleOffset: Int
    /// The count of the schedules which are called simultaneously.
    var schedulesTotalCount: Int
    /// The count of times which this instance re-called itself.
    var lifecyclesPassed = 0
    /// Possible regions which this schedule can search for.
    private let allRegions = getRegions()
    
    // Below variables are used to make this schedule testable,
    // by giving us the ability to discontinue the execution of
    // this schedule, after a time that we deem appropriate.
    
    /// The time in which the first schedule was called.
    var startInterval = Date().timeIntervalSince1970
    /// The approximate amount of time in which this
    /// schedule is supposed to continue working.
    var lifeTime: TimeInterval? = nil
    var hasPassedLifeTime: Bool {
        guard let lifeTime = lifeTime else { return false }
        let timeLived = (Date().timeIntervalSince1970 - startInterval)
        return lifeTime <= timeLived
    }
    
    func run(context: QueueContext) -> EventLoopFuture<Void> {
        let region = calculateRegion()
        let regionLeaderboard = getRegionLeaderboard(region: region, context: context)
        let databaseSave = regionLeaderboard.and(value: context).flatMap(saveToDb)
        let ignoreErrors = databaseSave.flatMapErrorThrowing { _ in () }
        let recall = ignoreErrors.flatMap { _ -> ELF<Void> in
            // To stop the schedule in tests, after the lifetime is passed.
            let isTesting = context.application.environment == .testing
            if isTesting && hasPassedLifeTime {
                return context.eventLoop.makeSucceededVoidFuture()
            }
            // New task to run, increasing the `lifecyclesPassed` by 1.
            let newTask = Self(scheduleOffset: self.scheduleOffset,
                               schedulesTotalCount: self.schedulesTotalCount,
                               lifecyclesPassed: self.lifecyclesPassed + 1,
                               startInterval: startInterval,
                               lifeTime: lifeTime)
            return context.eventLoop.flatScheduleTask(in: .nanoseconds(0)) {
                newTask.run(context: context)
            }.futureResult
        }
        
        return recall
    }
    
}

private extension UpdatePlayersLeaderboard {
    /// Retrieve region's leaderboard players from CRAPI.
    func getRegionLeaderboard(region: Regions, context: QueueContext)
    -> ELF<[Leaderboard.Item]> {
        let app = context.application
        let clientRequest = CRAPIRequest.locationsTopPlayers(location: region).clientRequest
        let clientResponse = app.client.send(clientRequest)
        let content = clientResponse.map {
            response -> [Leaderboard.Item] in
            let data = response.body.contentData()
            let decoded = try? Leaderboard(jsonUTF8Data: data, options: .ignoringUnknownFields)
            let items = decoded?.items ?? .init()
            
            return items
        }
        
        return content
    }
}

private extension UpdatePlayersLeaderboard {
    func saveToDb(leaderboard: [Leaderboard.Item], context: QueueContext) -> ELF<Void> {
        let redis = context.application.redis
        let nowInterval = Int(Date().timeIntervalSince1970)
        typealias RESPPlayer = (element: String, score: Double)
        // Filter out leaderboard players who don't
        // have a reasonable amount of trophies.
        let newLeaderboard = leaderboard.compactMap {
            item -> Leaderboard.Item? in
            /* players with less than 4K trophies are useless.
             trophies MUST always have 4 digits for decoding purposes. */
            guard (item.trophies >= 4000),
                  (item.trophies < 10000) else {
                return nil
            }
            return item
        }
        // Turn leaderboard players into redis-compatible
        // pairs of value and score.
        let rankings = newLeaderboard.compactMap { item -> RESPPlayer? in
            let value = item.respValue
            let score = item.respScore(timeInterval: nowInterval)
            guard !value.isEmpty, score != 0 else {
                return nil
            }
            return (value, score)
        }
        
        // Redis doesn't like empty arrays.
        guard !rankings.isEmpty else {
            return context.eventLoop.makeSucceededVoidFuture()
        }
        // Add the players to redis database.
        let redisKey = RedisKey(for: .playerLeaderboardItems)
        let addNewItems = redis.zadd(rankings, to: redisKey)
        
        return addNewItems.transform(to: ())
    }
}

private extension UpdatePlayersLeaderboard {
    /// Calculates index of the region that should be used for
    /// this instance of `UpdatePlayersLeaderboard` schedule.
    /// then return the region.
    func calculateRegion() -> Regions {
        let regionsCount = allRegions.count
        let totalIndex = (scheduleOffset + (lifecyclesPassed * schedulesTotalCount))
        let regionIndex = totalIndex % regionsCount
        return allRegions[regionIndex]
    }
}

/// Regions that a schedule can possibly search for.
private func getRegions() -> [Regions] {
    // These three above constants Do not and Should not have overlap on their members
    
    /*
     let regionsWithLessThan1000Players: [Regions] = [.All, ._EU, ._NA, ._SA, ._AS, ._AU, ._AF, ._INT, .AX, .AS, .AD, .AO, .AI, .AQ, .AG, .AW, .AC, .BS, .BJ, .BM, .BT, .BW, .BV, .IO, .VG, .BF, .BI, .IC, .BQ, .KY, .CF, .EA, .TD, .CX, .CC, .KM, .CG, .CD, .CK, .CW, .DG, .DJ, .DM, .GQ, .ER, .ET, .FK, .FO, .FJ, .PF, .TF, .GA, .GM, .GH, .GI, .GL, .GD, .GG, .GN, .GW, .GY, .HT, .HM, .IM, .JE, .KE, .KI, .XK, .LS, .LR, .LI, .MW, .ML, .MH, .MR, .YT, .FM, .MC, .MS, .MZ, .NA, .NR, .NC, .NE, .NU, .NF, .KP, .MP, .PW, .PG, .PN, .RW, .BL, .SH, .KN, .LC, .MF, .PM, .WS, .SM, .ST, .SN, .SC, .SL, .SX, .SB, .SO, .SS, .VC, .SR, .SJ, .SZ, .TZ, .TL, .TG, .TK, .TO, .TA, .TC, .TV, .UM, .VI, .UG, .VU, .VA, .WF, .EH, .ZM, .ZW]
     */
    
    /// Regions who at the time that i was writing this app,
    /// didn't have even 1 player in the global leaderboard.
    let regionsWithNoTop1000Player: [Regions] = [.AF, .AM, .AZ, .BH, .BB, .BZ, .BA, .BN, .KH, .CM, .CV, .CI, .CU, .DK, .DO, .EE, .FI, .GF, .GP, .GU, .IS, .JM, .KW, .LA, .LV, .LT, .LU, .MO, .MK, .MG, .MV, .MT, .MU, .MD, .MN, .MM, .NZ, .NG, .NO, .PS, .PH, .QA, .RE, .SI, .LK, .SD, .CH, .TH, .TT, .TM, .AE, .UZ, .YE, .PR]
    let otherRegions: [Regions] = [.AL, .DZ, .AR, .AU, .AT, .BD, .BY, .BE, .BO, .BR, .BG, .CA, .CL, .CN, .CO, .CR, .HR, .CY, .CZ, .EC, .EG, .SV, .FR, .GE, .DE, .GR, .GT, .HN, .HK, .HU, .IN, .ID, .IR, .IQ, .IE, .IL, .IT, .JP, .JO, .KZ, .KG, .LB, .LY, .MY, .MQ, .MX, .ME, .MA, .NP, .NL, .NI, .OM, .PK, .PA, .PY, .PE, .PL, .PT, .RO, .RU, .SA, .RS, .SG, .SK, .ZA, .KR, .ES, .SE, .SY, .TW, .TJ, .TN, .TR, .UA, .GB, .US, .UY, .VE, .VN]
    
    let regionsWithRatio = otherRegions + regionsWithNoTop1000Player + otherRegions
    
    return regionsWithRatio
}
