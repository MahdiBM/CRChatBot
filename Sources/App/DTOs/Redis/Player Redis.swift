import Redis
import Vapor

/*
 MARK: Explanation of the Values that are saved to redis for `RedisKey(for: .playerLeaderboardItems)`
 
 These Values have two components.
 1- score, must be of type Double for redis.
 2- value, can be of any type conforming to RESPValueConvertible, but here is String.
 
 Redis makes rankings out of based on their scores.
 Here we don't really need the ranking feature,
 but we use this method to get values that are in a score range.
 
 A player needs at least 4 properties before it can be saved to redis.
 1- tag: String
 2- name: String
 3- trophies: Int
 4- timestamp: Int, the timestamp since 1970,
    pointing to the time that the player is being saved to redis.
 
 How is score calculated?
 score = Double("\(player.trophies)\(player.timestamp)")
 
 How is value calculated?
 value = player.tag + "@%&*" + player.name
 
 Below here, in DTOs.Redis.Player.init what you see
 is basically extracting those same 4 values that a player has,
 from the redis's `score` and `value`,
 to a nice Swift type (DTOs.Redis.Player) which we can work with much easier.
*/

extension DTOs.Redis {
    struct Player: Content {
        var tag: String
        var name: String
        var trophies: Int
        var timestamp: Int
        
        private init? (value: String?, score scoreString: String?) {
            guard let value = value,
                  let scoreString = scoreString,
                  let scoreStr = try? String(Int(Double(scoreString).throwingUnwrap()))  else {
                return nil
            }
            
            // As explained above, `tag` and `name` are separated
            // with "@%&*" between them.
            // so valueComps[0] == valuesComps.first == `tag`
            // and valueComps[1] == valuesComps.last == `name`
            let valueComps = value.components(separatedBy: "@%&*")
            let tag = valueComps.first
            let name = valueComps.last
            let scoreLength = scoreStr.count
            /* No players with a non-4-digit trophies should be saved onto the db
             here we assume that a player's trophies is always a 4-digit number */
            let trophyLength = 4
            // timestamp is all the digits
            // in the string other than the first 4.
            let timestampStr = String(scoreStr.dropFirst(trophyLength))
            let timestamp = Int(timestampStr)
            // trophies is the first 4 digits.
            let trophies = Int(String(scoreStr.dropLast(scoreLength - trophyLength)))
            
            // Unwrap all or fail.
            guard let tagU = tag,
                  let nameU = name,
                  let trophiesU = trophies,
                  let timestampU = timestamp else {
                return nil
            }
            
            self.tag = tagU
            self.name = nameU
            self.trophies = trophiesU
            self.timestamp = timestampU
        }
    }
}

extension DTOs.Redis.Player {
    static let redisKey = RedisKey(for: .playerLeaderboardItems)
    
    /// Makes a range for a single score (player trophy)
    /// with a reasonable time range.
    /// - Parameters:
    ///   - reducer: Reduces the time interval in which
    ///   the players were saved into the redis database.
    private static func makeScoreRange(for score: Int,
                                       minIntervalReducer reducer: Double = 1)
    -> ClosedRange<Double> {
        let nowInterval = Int(Date().timeIntervalSince1970) + 5
        let threeMin = Double(3 * 60)
        let reducer = ((reducer > 1) && (reducer < 180)) ? reducer : 1
        let pastTime = threeMin / reducer
        let pastInterval = nowInterval - Int(pastTime)
        
        guard let maxScore = Double("\(score)\(nowInterval)"),
              let minScore = Double("\(score)\(pastInterval)"),
              maxScore > minScore else {
            return 0...0
        }
        
        return minScore...maxScore
    }
    
    /// Loads players which have the provided score from redis.
    static func loadFromDb(_ req: Request,
                           for score: Int,
                           intervalReducer reducer: Double = 1)
    -> ELF<[Self]> {
        let range = Self.makeScoreRange(for: score, minIntervalReducer: reducer)
        // Get values that are in the score range.
        let valuesForScoreRange = req.redis.zrangebyscore(from: redisKey, withScores: range)
        // Values are originally saved to redis as strings,
        // so we convert them to strings.
        let stringValues = valuesForScoreRange.map { values -> [String] in
            values.map { $0.description }
        }
        // Retrieves values of the scores from redis Db.
        let valuesWithScores = stringValues.flatMapEachCompact(on: req.eventLoop) {
            value -> ELF<Self?> in
            req.redis.zscore(of: value, in: redisKey)
                .map { Self.init(value: value, score: $0?.description) }
        }
        
        // Tries to recover from redis timeout errors by
        // giving redis a smaller range of player-scores to search for.
        let recoverIfFailed = valuesWithScores.flatMapError { error -> ELF<[Self]> in
            var isTimeoutError: Bool {
                let redisError = error as? RedisConnectionPoolError
                return redisError == .timedOutWaitingForConnection
            }
            let newReducer = reducer * 3
            // 180 is due to 3 mins (3 * 60)
            // + the implementation of the `makeScoreRange` function.
            if isTimeoutError && newReducer < 180 {
                return Self.loadFromDb(req, for: score, intervalReducer: newReducer)
            }
            else {
                return req.eventLoop.future([])
            }
        }
        
        return recoverIfFailed
    }
}

