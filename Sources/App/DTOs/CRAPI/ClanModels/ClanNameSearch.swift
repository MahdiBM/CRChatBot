import Foundation

private typealias ClanNameSearch = DTOs.CRAPI.ClanNameSearch

extension DTOs.CRAPI {
    struct ClanNameSearch: Codable, EmptyInitializable {
        @DecodeNilable var items: [Item] = .init()
    }
}

extension ClanNameSearch {
    struct Location: Codable, EmptyInitializable {
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var isCountry: Bool = .init()
        @DecodeNilable var countryCode: String = .init()
    }
}

extension ClanNameSearch {
    struct Item: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var type: String = .init()
        @DecodeNilable var badgeId: Int = .init()
        @DecodeNilable var badgeName: String = .init()
        @DecodeNilable var clanScore: Int = .init()
        @DecodeNilable var clanWarTrophies: Int = .init()
        @DecodeNilable var location: Location = .init()
        @DecodeNilable var donationsPerWeek: Int = .init()
        @DecodeNilable var clanChestLevel: Int = .init()
        @DecodeNilable var clanChestMaxLevel: Int = .init()
        @DecodeNilable var members: Int = .init()
        
        func populate() -> Self {
            var model = self
            model.badgeName = DTOs.CRAPI.Funcs.Clan.badgeName(badgeId: model.badgeId)
            return model
        }
    }
}

extension ClanNameSearch {
    func populate() -> DTOs.CRAPI.ClanNameSearch {
        return .init(items: self.items.map {$0.populate()})
    }
}
