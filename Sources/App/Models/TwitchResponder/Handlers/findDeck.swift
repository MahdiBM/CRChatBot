import Redis

private typealias Leaderboard = DTOs.CRAPI.PlayerLeaderboard
private typealias Battles = [DTOs.CRAPI.PlayerBattle]

extension TwitchResponder {
    func findDeck(using trophies: Int, filterBy filterString: String?) -> ELF<String> {
        let minLeaderboardTrophies = req.redis.get(RedisKey(for: .minimumGlobalLeaderboardTrophies))
        let getLeaderboard = minLeaderboardTrophies
            .flatMap { value -> ELF<[Leaderboard.Item]> in
                /*
                 If the input trophies is less than the min trophies that a player needs
                 to have to appear in the global leaderboard, then only load
                 players from redis db, and don't even bother to retrieve the
                 global leaderboard from CRAPI.
                 */
                if let minTrophies = value.int,
                   minTrophies > trophies {
                    return getPlayersFromDatabase(for: trophies)
                } else {
                    // Else, retrieve the global leaderboard.
                    return getGlobalLeaderboard()
                }
            }
        let populatedLeaderboard = getLeaderboard.flatMap {
            leaderboard -> ELF<[Leaderboard.Item]> in
            /*
             If any if two below conditions are false, then it tries
             to get values from the redis db.
             1- `let minTrophies = leaderboard.map(\.trophies).min()`: Will only be
             nil if there was a problem with getting info from CRAPI.
             In that case, we try to get players from the redis db.
             2- If minTrophies is more than the trophies entered by the user,
             then there is no reason to load from redis db since the player
             should first be in the global leaderboard so then it might be
             in redis db as well.
             */
            guard let minTrophies = leaderboard.map(\.trophies).min(),
                  trophies >= minTrophies else {
                return getPlayersFromDatabase(for: trophies)
            }
            return req.eventLoop.future(leaderboard)
        }
        let filteredByTrophies = populatedLeaderboard.map {
            leaderboard -> [Leaderboard.Item] in
            // `$0.tag == ""` means player is straight up invalid since every
            // player must have a tag as a unique in-game identifier.
            // Then we filter players with trophies that user has input-ed.
            leaderboard.filter { $0.tag != "" }
                .filter { $0.trophies == trophies }
        }
        let filteredByUserArgument = filteredByTrophies
            .and(value: filterString).flatMapThrowing(filterPlayers)
        let guardedFromTooManyPlayers = filteredByUserArgument
            .and(value: filterString).flatMapThrowing(guardFromTooManyPlayers)
        let battleData = guardedFromTooManyPlayers.flatMap(getBattleData)
        let lastLadderBattles = battleData.flatMapThrowing(getLastLadderBattles)
        let decksString = lastLadderBattles.flatMapThrowing(makeString)
        
        return decksString
    }
    
}

private extension TwitchResponder {
    /// Retrieves global leaderboard from CRAPI,
    /// and return all the players in the leaderboard.
    /// Meanwhile saves the minimum trophies of the leaderboard players
    /// into `RedisKey(for: .minimumGlobalLeaderboardTrophies)`.
    func getGlobalLeaderboard() -> ELF<[Leaderboard.Item]> {
        let clientRequest = CRAPIRequest.locationsTopPlayersGlobal.clientRequest
        let clientResponse = req.client.send(clientRequest)
        let content = clientResponse.flatMapThrowing {
            response -> [Leaderboard.Item] in
            guard let decoded = try? response.content.decode(Leaderboard.self),
                  decoded.items.count != 0 else {
                throw Responses.failedToCommunicateWithCRAPI(errorId: 21923)
            }
            return decoded.items
        }
        // Battles are originally sorted with the player who e.g. battled a long
        // time ago in front, while the players who battled recently being
        // at the end. So it is very helpful to reverse the order.
        let newContent = content.map { Array($0.reversed()) }
        let saveToRedis = newContent.flatMap {
            leaderboard -> ELF<[Leaderboard.Item]> in
            // If there is a minimum trophies, save it to redis.
            // Otherwise(!) don't interrupt the operation since this
            // is not something vital.
            if let min = leaderboard.map(\.trophies).min() {
                let redisKey = RedisKey(for: .minimumGlobalLeaderboardTrophies)
                let saved = req.redis.set(redisKey, to: min)
                return saved.transform(to: leaderboard)
            } else {
                return req.eventLoop.future(leaderboard)
            }
        }
        
        return saveToRedis
    }
}

private extension TwitchResponder {
    /// Loads players for the specified trophies from redis db.
    func getPlayersFromDatabase(for trophies: Int) -> ELF<[Leaderboard.Item]> {
        let redisPlayers = DTOs.Redis.Player.loadFromDb(req, for: trophies)
        // Sort players descending-ly based on the date they were
        // saved into the db.
        let sortedRedisPlayers = redisPlayers.map { players in
            players.sorted { $0.timestamp > $1.timestamp }
        }
        // Convert players to instances of `Leaderboard.Item` to unify
        // the type with other funcs that are used in this whole process.
        let leaderboardItems = sortedRedisPlayers.mapEach { player in
            Leaderboard.Item.init(
                tag: player.tag,
                name: player.name,
                trophies: player.trophies
            )
        }
        let guardedFromEmpty = leaderboardItems.flatMapThrowing {
            items -> [Leaderboard.Item] in
            guard !items.isEmpty else {
                throw Responses.noResults
            }
            return items
        }
        
        return guardedFromEmpty
    }
}

private extension TwitchResponder {
    /// Filters the players by their name, using user's provided filter string.
    func filterPlayers(leaderboard: [Leaderboard.Item], filterString: String?)
    throws -> [Leaderboard.Item] {
        
        // If there is a filter string, then filter,
        // otherwise return the results back.
        var filtered = leaderboard
        if var filterString = filterString?.lowercased(),
           !filterString.removing(" ").isEmpty {
            
            // Check if user has entered a filter string which represents
            // one of the supported typing languages, so then
            // we can filter players whose names are in that language.
            let comps = filterString.components(separatedBy: " ")
            let typingLangs = comps.compactMap {
                TypingLanguage($0)
            }
            if !typingLangs.isEmpty {
                // Remove the parts of the filter string which represent
                // one of the supported languages.
                let compsWithNoTypingLangs = comps.filter {
                    TypingLanguage($0) == nil
                }
                // Join components back together to make the filter string
                // that has no typing-lang- representatives in it
                filterString = compsWithNoTypingLangs.joined(separator: " ")
                // Now filter players whose names doesn't contain
                // any word of the user-requested language.
                for lang in typingLangs {
                    filtered = filtered.filter {
                        // " | " string has proved problematic.
                        $0.name.removing("丨")
                            .contains(language: lang)
                    }
                }
            }
            
            // Filter players by the user-requested filter string.
            if !filterString.removing(" ").isEmpty {
                filtered = leaderboard.filter {
                    let foldedFilterString = filterString.folding(options: .diacriticInsensitive, locale: nil)
                    let foldedName = $0.name.folding(options: .diacriticInsensitive, locale: nil)
                    return foldedName.contains(foldedFilterString)
                }
            }
        }
        
        switch filtered.isEmpty {
        case true: throw Responses.noResults
        case false: return filtered
        }
    }
}

private extension TwitchResponder {
    /// Throws if there are too many players found. if there are too many
    /// players, the results will become meaning-less, so we preemptively
    /// throw an error here and ask user for more/better filter string.
    func guardFromTooManyPlayers(leaderboard: [Leaderboard.Item], filterString: String?)
    throws -> [Leaderboard.Item] {
        let countMoreThan10 = leaderboard.count > 10
        let hasFilterString = (filterString != nil)
            && (filterString?.removing(" ") != "")
        guard !countMoreThan10 else {
            let message: String
            switch hasFilterString {
            case true: message = "The provided filter argument was not helpful."
                + " Player must be in their own local leaderboard so"
                + " we can find them."
            case false: message = "You provided no filter arguments and more than"
                + " 10 players were found. Please include a filter argument so we"
                + " can filter out the players with unrelated names."
            }
            throw Responses.custom(message)
        }
        // Even if there are only ~ 10 players found, we should
        // still only try to find 4/5 players' info more than 4/5
        // will only be useless load on the app because NightBot
        // has a 400-letters limit for responses, and long-story short,
        // 4/5 players will fill those ~400-letters limit.
        return leaderboard.maxCount(4)
    }
}

private extension TwitchResponder {
    /// Retrieves battle logs of each of the input-ed players.
    func getBattleData(for leaderboard: [Leaderboard.Item]) -> ELF<[Battles]> {
        let battleRequests = leaderboard.map { item -> ELF<Battles> in
            let clientRequest = CRAPIRequest.playersBattleLog(tag: item.tag).clientRequest
            let clientResponse = req.client.send(clientRequest)
            let content = clientResponse.flatMapThrowing {
                response -> Battles in
                guard let decoded = try? response.content.decode(Battles.self) else {
                    throw Responses.failedToCommunicateWithCRAPI(errorId: 327328)
                }
                return decoded
            }
            return content
        }
        let flatBattles = battleRequests.flatten(on: req.eventLoop)
        let noResultsIfError = flatBattles.flatMapErrorThrowing { error -> [Battles] in
            throw (error is Responses) ? error : Responses.noResults
        }
        
        return noResultsIfError
    }
}

private extension TwitchResponder {
    /// Returns last ladder battle of each of the players, if they have any.
    func getLastLadderBattles(of allBattles: [Battles]) throws -> Battles {
        let lastLadderBattles = allBattles.compactMap { playerBattles in
            playerBattles.first { battle in
                isLadderBattle(gameModeName: battle.gameMode.name,
                               teamCount: battle.team.count)
            }
        }
        guard !lastLadderBattles.isEmpty else {
            throw Responses.noResults
        }
        return lastLadderBattles
    }
    
    /// Finds out whether or not a battle is a ladder battle.
    private func isLadderBattle(gameModeName title: String, teamCount: Int) -> Bool {
        teamCount == 1 &&
            (title == "Ladder"
                || title == "Ladder_CrownRush"
                || title == "Ladder_GoldRush"
                || title == "Ladder_GemRush")
    }
}

private extension TwitchResponder {
    /// Makes a response string out of the battles that are passed to it.
    func makeString(for battles: Battles) throws -> String {
        let deckStrings = battles.compactMap { battle in
            makeDeckString(for: battle)
        }
        // Here strings are appended together with a separator in-between
        // each string, and we cautiously check not to exceed the 400-letters
        // limit of the NightBot, because NightBot will show an error
        // message to users if we exceed the limit.
        let finalString = deckStrings.enumerated().reduce("") { lhs, rhs in
            let separator = (rhs.offset != 0) ? " ——— \n" : ""
            let withFinalString = lhs + separator + rhs.element
            // NightBot limit 400, minus 25 (= 375) for "/me @Username"
            // which will be appended to the beginning of this string in the
            // final step, before sending the response string to NightBot.
            guard withFinalString.count < 375 else {
                return lhs
            }
            return withFinalString
        }
        guard !finalString.isEmpty else {
            throw Responses.noResults
        }
        
        return finalString
    }
    
    /// Makes a string which includes a player's name and
    /// used-cards in the battle that is passed to the function.
    private func makeDeckString(for battle: Battles.Element) -> String? {
        // This guard condition is always met, here just being cautious.
        guard let name = battle.team.first?.name,
              let cards = battle.team.first?.cards,
              cards.count == 8 else {
            return nil
        }
        // Finding the names of the cards.
        let cardStrings = cards.map { card -> String in
            // Getting cards's info from the data set.
            let cardEnumValue: DataSet.Cards = .find(id: card.id)
            let info = cardEnumValue.info
            let cardName = info.shortName ?? info.name
            return cardName
        }
        // And finally, deck string is made by appending players' name
        // and card names together.
        let deckString = "\(name): " + cardStrings.joined(separator: ", ")
        
        return deckString
    }
}

private extension Array {
    /// Returns the array having the maximum
    /// element count of the entered value.
    func maxCount(_ count: Int) -> Self {
        let selfCount = self.count
        let dropLastCount = (selfCount > count) ? (selfCount - count) : 0
        return self.dropLast(dropLastCount)
    }
}
