import Foundation

private typealias ClanWarLog = DTOs.CRAPI.ClanWarLog

extension DTOs.CRAPI {
    struct ClanWarLog: Codable, EmptyInitializable {
        @DecodeNilable var items: [Item] = .init()
    }
}

extension ClanWarLog {
    struct Item: Codable, EmptyInitializable {
        @DecodeNilable var seasonId: Int = .init()
        @DecodeNilable var createdDate: String = .init()
        @DecodeNilable var standings: [ParticipantClan] = .init()
        
        func populate() -> Self {
            var model = self
            model.standings = standings.map {$0.populate()}
            return model
        }
    }
}


extension ClanWarLog {
    struct Participant: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var fame: Int = .init()
        @DecodeNilable var repairPoints: Int = .init()
    }
}

extension ClanWarLog {
    struct ParticipantClan: Codable, EmptyInitializable {
        @DecodeNilable var clan: ClanInfo = .init()
        @DecodeNilable var trophyChange: Int = .init()
        @DecodeNilable var rank: Int = .init()
        
        func populate() -> Self {
            return .init(clan: self.clan.populate(),
                         trophyChange: self.trophyChange,
                         rank: self.rank)
        }
    }
}

extension ClanWarLog {
    struct ClanInfo: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var badgeId: Int = .init()
        @DecodeNilable var badgeName: String = .init()
        @DecodeNilable var clanScore: Int = .init()
        @DecodeNilable var participants: [Participant] = .init()
        @DecodeNilable var fame: Int = .init()
        @DecodeNilable var repairPoints: Int = .init()
        @DecodeNilable var finishTime: String = .init()
//        @DecodeNilable var battlesPlayed: Int = .init()
//        @DecodeNilable var wins: Int = .init()
//        @DecodeNilable var crowns: Int = .init()
        
        func populate() -> Self {
            var model = self
            model.badgeName = DTOs.CRAPI.Funcs.Clan.badgeName(badgeId: model.badgeId)
            return model
        }
    }
}

extension ClanWarLog {
    func populate() -> DTOs.CRAPI.ClanWarLog {
        return .init(items: self.items.map {$0.populate()})
    }
}
