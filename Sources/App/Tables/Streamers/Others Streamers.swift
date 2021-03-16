
//MARK: - InfoDict Stuff

extension Streamers {
    enum InfoKeys: String, CaseIterable {
        case streamerName
        case streamerTag
        
        var name: String {
            switch self {
            case .streamerName: return "Streamer Name"
            case .streamerTag: return "Streamer Tag"
            }
        }
        
        var acceptableValues: [String] {
            switch self {
            case .streamerName: return ["streamername", "name"]
            case .streamerTag: return ["streamertag", "tag"]
            }
        }
    }
}

extension Streamers {
    func info(for key: Streamers.InfoKeys) -> String? {
        self.infoDict[key.rawValue]
    }
}

//MARK: -Equatable Conformance
extension Streamers: Equatable {
    public static func == (lhs: Streamers, rhs: Streamers) -> Bool {
        lhs.channelName == rhs.channelName
            && lhs.lastOnline == rhs.lastOnline
            && lhs.isBlacklisted == rhs.isBlacklisted
            && lhs.performOnlineChecks == rhs.performOnlineChecks
            && lhs.infoDict == rhs.infoDict
    }
}


