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
                throw ResponseError.noNightBot
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
        let userLevel: String
        
        fileprivate init? (headers: HTTPHeaders) {
            guard let dict = makeDict(for: "Nightbot-User", headers: headers) else {
                return nil
            }
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
    }
}

extension TwitchResponder.NightBot {
    struct TwitchChannel {
        let name: String
        let displayName: String
        let provider: String
        let providerId: String
        
        fileprivate init? (headers: HTTPHeaders) {
            guard let dict = makeDict(for: "Nightbot-Channel", headers: headers) else {
                return nil
            }
            
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

private extension TwitchResponder.NightBot {
    /// Gets the value of a key from the dict that is made
    /// using the below `makeDict(for:headers:)` function.
    static func value(for key: String, dict: [[String]]) -> String? {
        guard let idx = (dict.firstIndex { $0[0] == key }) else {
            return nil
        }
        return dict[idx][1]
    }
    
    /// Makes a dict-like array out of the header that NightBot gives the app.
    static func makeDict(for headerName: String, headers: HTTPHeaders) -> [[String]]? {
        guard let headerString = headers.first(name: headerName) else {
            return nil
        }
        // Concatenating the header and making a dict-like array out of it.
        let dict = headerString.split(separator: "&")
            .map { $0.split(separator: "=").map { String($0) } }
        // Making sure the values are pair-values.
        guard dict.map({ $0.count }).filter({ $0 != 2 }).count == 0 else {
            return nil
        }
        return dict
    }
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
