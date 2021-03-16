import Vapor

private typealias Player = DTOs.CRAPI.PlayerProfile

extension TwitchResponder {
    func findRank(preferredTag: String?) -> ELF<String> {
        let channelName = nightBot.twitchChannel.name.lowercased()
        let responseString: ELF<String>
        
        // If the user has input-ed an extra arg with more than 2 chars,
        // the app will take that arg as a player-tag, and will try
        // to find that player-tag's rank.
        if let preferredTag = preferredTag,
           preferredTag.count >= 3 {
            responseString = getResponseString(tag: preferredTag, hasPreferredTag: true)
        } else {
            // Otherwise if there is not a good extra arg, then try
            // to find rank of the streamer.
            let streamerTagAndName = Streamers.query(on: req.db)
                .filter(\.$channelName, .equal, channelName)
                .first()
                .flatMapThrowing { streamer -> (name: String, tag: String) in
                    switch streamer {
                    // Else, try to retrieve streamer's tag and name, so we can
                    // get his rank info using his player tag.
                    case let streamer?: return try getStreamerTagAndName(streamer: streamer)
                    // Streamer must be in db if a request has passed the validation,
                    // assuming this not a Admin request and is from NightBot.
                    default: throw ResponseError.unknownFailure(errorId: 89483)
                    }
                }
            
            let streamerRankString = streamerTagAndName.flatMap {
                info -> ELF<String> in
                getResponseString(tag: info.tag, name: info.name)
            }
            responseString = streamerRankString
        }
        
        return responseString
    }
}

private extension TwitchResponder {
    func getStreamerTagAndName(streamer: Streamers) throws -> (name: String, tag: String) {
        let streamerName = streamer.info(for: .streamerName)
        let streamerTag = streamer.info(for: .streamerTag)
        
        switch streamerName {
        case let unwrappedName?:
            switch streamerTag {
            case let unwrappedTag?:
                return (name: unwrappedName, tag: unwrappedTag)
            default:
                throw ResponseError.custom("You need to first set streamer tag using command '!cr set tag STREAMER_TAG_HERE'. MUST NOT CONTAIN '#'")
            }
        default:
            switch streamerTag {
            case nil:
                throw ResponseError.custom("You need to first set streamer name using command '!cr set name STREAMER_NAME_HERE' and set streamer tag using command '!cr set tag STREAMER_TAG_HERE'. MUST NOT CONTAIN '#'")
            default:
                throw ResponseError.custom("You need to first set streamer name using command '!cr set name STREAMER_NAME_HERE'.")
            }
        }
    }
}

private extension TwitchResponder {
    /// Get data about player from CRAPI then makes rank string out of them.
    func getResponseString(tag: String, name defaultName: String? = nil, hasPreferredTag: Bool = false)
    -> ELF<String> {
        // Retrieves player's info from CRAPI.
        let seasonStats = getPlayerStats(tag: tag, hasPreferredTag: hasPreferredTag)
        // Makes rank explanation out of Player's info.
        let rankExplanationString = seasonStats.flatMapThrowing { player -> String in
            let name = defaultName ?? ("'" + player.name + "'")
            let currentSeason = player.leagueStatistics.currentSeason
            let highest = populate(currentSeason.bestTrophies)
            let current = populate(currentSeason.trophies)
            let rank = populate(currentSeason.rank)
            if highest == current && current == rank && rank == "Unknown" {
                throw ResponseError.custom("Could not retrieve valid player stats."
                                            + " make sure your entered tag is correct.")
            }
            let response = name
                + " is currently ranked #\(rank) globally, with \(current) 🏆."
                + " His current season best is \(highest) 🏆."
            return response
        }
        
        return rankExplanationString
    }
    
    private func populate(_ int: Int) -> String {
        switch int {
        case 0: return "Unknown"
        default: return "\(int)"
        }
    }
    
    /// Retrieves player's profile from CRAPI.
    private func getPlayerStats(tag: String, hasPreferredTag: Bool) -> ELF<Player> {
        let clientRequest = CRAPIRequest.playersSearch(tag: tag).clientRequest
        let clientResponse = req.client.send(clientRequest)
        let content = clientResponse.flatMapThrowing { response -> Player in
            guard let decoded = try? response.content.decode(Player.self) else {
                throw ResponseError.failedToCommunicateWithCRAPI(errorId: 9329)
            }
            return decoded
        }
        let guardedFromBeingInvalid = content.flatMapThrowing { player -> Player in
            guard player.tag.removing(" ") != "" else {
                let suffix = " Something went wrong while"
                    + " communicating with the Official Clash Royale API."
                    + " No. 83294."
                switch hasPreferredTag {
                case true: throw ResponseError
                    .custom("Make sure your input tag is correct." + suffix)
                case false: throw ResponseError
                    .custom("Make sure streamer tag is correct. You can change streamer"
                                + " tag using command `!cr set tag STREAMER_TAG_HERE`."
                                + " Do NOT include the `#`."
                                + suffix)
                }
            }
            return player
        }
        return guardedFromBeingInvalid
    }
}
