import Foundation

private typealias ClanLeaderboard = DTOs.CRAPI.ClanLeaderboard

extension DTOs.CRAPI {
    struct ClanLeaderboard: Codable, EmptyInitializable {
        @DecodeNilable var items: [Item] = .init()
    }
}

extension ClanLeaderboard {
    struct Item: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var rank: Int = .init()
        @DecodeNilable var previousRank: Int = .init()
        @DecodeNilable var location: Location = .init()
        @DecodeNilable var clanScore: Int = .init()
        @DecodeNilable var members: Int = .init()
        @DecodeNilable var badgeId: Int = .init()
        @DecodeNilable var badgeName: String = .init()
        
        func populate() -> Self {
            var model = self
            model.badgeName = DTOs.CRAPI.Funcs.Clan.badgeName(badgeId: self.badgeId)
            return model
        }
    }
}

extension ClanLeaderboard {
    struct Location: Codable, EmptyInitializable {
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var isCountry: Bool = .init()
        @DecodeNilable var countryCode: String = .init()
    }
}

extension ClanLeaderboard {
    func populate() -> DTOs.CRAPI.ClanLeaderboard {
        return .init(items: self.items.map {$0.populate()})
    }
}
