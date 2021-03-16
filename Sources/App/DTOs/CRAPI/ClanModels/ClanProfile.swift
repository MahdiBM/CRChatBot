import Foundation

private typealias ClanProfile = DTOs.CRAPI.ClanProfile

extension DTOs.CRAPI {
    struct ClanProfile: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var type: String = .init()
        @DecodeNilable var description: String = .init()
        @DecodeNilable var badgeId: Int = .init()
        @DecodeNilable var badgeName: String = .init()
        @DecodeNilable var clanScore: Int = .init()
        @DecodeNilable var clanWarTrophies: Int = .init()
        @DecodeNilable var location: Location = .init()
        @DecodeNilable var requiredTrophies: Int = .init()
        @DecodeNilable var donationsPerWeek: Int = .init()
        @DecodeNilable var clanChestStatus: String = .init()
        @DecodeNilable var clanChestLevel: Int = .init()
        @DecodeNilable var clanChestMaxLevel: Int = .init()
        @DecodeNilable var members: Int = .init()
        @DecodeNilable var memberList: [Member] = .init()
    }
}

extension ClanProfile {
    struct Location: Codable, EmptyInitializable {
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var isCountry: Bool = .init()
        @DecodeNilable var countryCode: String = .init()
    }
}

extension ClanProfile {
    struct Arena: Codable, EmptyInitializable {
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var name: String = .init()
    }
}

extension ClanProfile {
    struct Member: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var role: String = .init()
        @DecodeNilable var lastSeen: String = .init()
        @DecodeNilable var expLevel: Int = .init()
        @DecodeNilable var trophies: Int = .init()
        @DecodeNilable var arena: Arena = .init()
        @DecodeNilable var clanRank: Int = .init()
        @DecodeNilable var previousClanRank: Int = .init()
        @DecodeNilable var donations: Int = .init()
        @DecodeNilable var donationsReceived: Int = .init()
        @DecodeNilable var clanChestPoints: Int = .init()
    }
}

extension DTOs.CRAPI.ClanProfile {
    func populate() -> Self {
        var model = self
        model.badgeName = DTOs.CRAPI.Funcs.Clan.badgeName(badgeId: model.badgeId)
        return model
    }
}
