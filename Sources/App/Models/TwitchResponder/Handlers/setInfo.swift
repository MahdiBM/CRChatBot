import Vapor

extension TwitchResponder {
    /// Sets Streamer's info.
    func setInfo(key: String, value: String) throws -> ELF<String> {
        let channelName = nightBot.twitchChannel.name.lowercased()
        // Restrict to owner/moderator
        let userLevel = nightBot.twitchUser?.userLevel
        guard userLevel == "owner" || userLevel == "moderator" else {
            throw ResponseError.streamerOrModNeeded
        }
        
        let streamer = Streamers.query(on: req.db)
            .filter(\.$channelName, .equal, channelName)
            .first()
        let setInfoResponse = streamer.tryFlatMap {
            streamer -> ELF<String> in
            switch streamer {
            case let streamer?: return try setInfo(for: streamer, key: key, value: value)
            // At this point, by my calculations, there must already be a streamer
            // and this will never be nil.
            default: throw ResponseError.unknownFailure(errorId: 93843)
            }
        }
        
        return setInfoResponse
    }
}

private extension TwitchResponder {
    private typealias Keys = Streamers.InfoKeys
    
    func setInfo(for streamer: Streamers, key: String, value: String)
    throws -> ELF<String> {
        
        // Returns true if the user input is acceptable for the enumCase.
        func keyFilter(case enumCase: Keys) -> Bool {
            enumCase.acceptableValues
                .map { $0.lowercased() }
                .contains(key.lowercased())
        }
        
        // Find enum case related to the user input.
        let allKeys = Keys.allCases
        guard let enumKey = (allKeys.filter { keyFilter(case: $0) }.first) else {
            let validKeys = allKeys.map(\.rawValue).joined(separator: ", ")
            throw ResponseError.custom("'\(key)' is not a valid key so you cant set values for it."
                                        + "Current valid keys are: " + validKeys)
        }
        
        // Set value to the key finally.
        let oldValue = streamer.info(for: enumKey)
        streamer.infoDict[enumKey.rawValue] = value
        return streamer.save(on: req.db).map { _ -> String in
            switch oldValue {
            case let oldValue?: return "Successfully changed value of '\(enumKey.name)'"
                + " from '\(oldValue)' to '\(value)'"
            default: return "Successfully set value of '\(enumKey.name)' to '\(value)'"
            }
        }
    }
}
