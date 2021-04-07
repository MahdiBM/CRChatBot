import Vapor

extension TwitchResponder {
    struct NightBot {
        let twitchUser: TwitchUser?
        let twitchChannel: TwitchChannel
        let responseURLString: String
        /// Whether the request is a timer NightBot request or is made by an actual user.
        var isScheduledRequest: Bool { twitchUser == nil }
        
        init(headers: HTTPHeaders) throws {
            guard let twitchChannel = TwitchChannel(headers: headers),
                  let responseURLString = headers.first(name: "Nightbot-Response-Url") else {
                throw Responses.noNightBot
            }
            
            self.twitchUser = TwitchUser(headers: headers)
            self.twitchChannel = twitchChannel
            self.responseURLString = responseURLString
        }
    }
}

extension TwitchResponder.NightBot {
    struct TwitchUser {
        let name: String
        let displayName: String
        let provider: String
        let providerId: String
        fileprivate let userLevel: String
        
        fileprivate init? (headers: HTTPHeaders) {
            let dict = makeDict(for: "Nightbot-User", headers: headers)
            guard let name = value(for: "name", dict: dict),
                  let displayName = value(for: "displayName", dict: dict),
                  let provider = value(for: "provider", dict: dict),
                  let providerId = value(for: "providerId", dict: dict),
                  let userLevel = value(for: "userLevel", dict: dict) else {
                return nil
            }
            
            self.name = name
            self.displayName = displayName
            self.provider = provider
            self.providerId = providerId
            self.userLevel = userLevel
        }
        
        // Throws if the user is not a moderator.
        func isModerator() throws {
            guard userLevel == "owner"
                    || userLevel == "moderator"
                    || name == "mahdimmbm" else {
                throw TwitchResponder.Responses.streamerOrModNeeded
            }
        }
    }
}

extension Optional where Wrapped == TwitchResponder.NightBot.TwitchUser {
    // Throws if the user is not a moderator.
    func isModerator() throws {
        guard let user = self else {
            throw TwitchResponder.Responses.streamerOrModNeeded
        }
        try user.isModerator()
    }
}

extension TwitchResponder.NightBot {
    struct TwitchChannel {
        let name: String
        let displayName: String
        let provider: String
        let providerId: String
        
        fileprivate init? (headers: HTTPHeaders) {
            let dict = makeDict(for: "Nightbot-Channel", headers: headers)
            guard let name = value(for: "name", dict: dict),
                  let displayName = value(for: "displayName", dict: dict),
                  let provider = value(for: "provider", dict: dict),
                  let providerId = value(for: "providerId", dict: dict) else {
                return nil
            }
            
            self.name = name
            self.displayName = displayName
            self.provider = provider
            self.providerId = providerId
        }
    }
}

/// Gets the value of a key from the dict that is made
/// using the below `makeDict(for:headers:)` function.
private func value(for key: String, dict: [String: String]) -> String? {
    guard let value = dict[key] else {
        return nil
    }
    return value
}

/// Makes a dict out of the header that NightBot gives the app.
private func makeDict(for headerName: String, headers: HTTPHeaders) -> [String: String] {
    guard let headerString = headers.first(name: headerName) else {
        return .init()
    }
    // Concatenating the header and making the dict out of it.
    let arrayOfArrays = headerString.split(separator: "&")
        .map { $0.split(separator: "=").map { String($0) } }
    // Making sure the values are pair-values.
    guard arrayOfArrays.filter({ $0.count != 2 }).count == 0 else {
        return .init()
    }
    let arrayOfKeyValues = arrayOfArrays.map { ($0[0], $0[1]) }
    let dict: [String: String] = .init(uniqueKeysWithValues: arrayOfKeyValues)
    return dict
}

extension TwitchResponder.NightBot {
    static var mockedValue: Self {
        let nbUser = "name=night&displayName=night&provider=twitch&providerId=11785491&userLevel=owner"
        let nbChannel = "name=night&displayName=Night&provider=twitch&providerId=11785491"
        let nbUrl = "https://api.nightbot.tv/1/channel/send/TVRRM05UazRNVGsyT1RnNE1TOWthWE5"
        let headers = HTTPHeaders([
            ("Nightbot-User", nbUser),
            ("Nightbot-Channel", nbChannel),
            ("Nightbot-Response-Url", nbUrl)
        ])
        
        return try! Self.init(headers: headers)
    }
}
