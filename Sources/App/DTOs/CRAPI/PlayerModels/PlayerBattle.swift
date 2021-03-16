import Foundation

private typealias PlayerBattle = DTOs.CRAPI.PlayerBattle

extension DTOs.CRAPI {
    struct PlayerBattle: Codable, EmptyInitializable {
        @DecodeNilable var type: String = .init()
        @DecodeNilable var challengeTitle: String = .init()
        @DecodeNilable var title: String = .init()
        @DecodeNilable var battleTime: String = .init()
        @DecodeNilable var challengeWinCountBefore: Int = .init()
        @DecodeNilable var isLadderTournament: Bool = .init()
        @DecodeNilable var arena: Arena = .init()
        @DecodeNilable var gameMode: GameMode = .init()
        @DecodeNilable var deckSelection: String = .init()
        @DecodeNilable var team: [Battler] = .init()
        @DecodeNilable var opponent: [Battler] = .init()
    }
}

extension PlayerBattle {
    struct Card: Codable, EmptyInitializable {
        @DecodeNilable var name: String = .init()
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var oldLevel: Int = .init()
        @DecodeNilable var level: Int = .init()
        @DecodeNilable var maxLevel: Int = .init()
        @DecodeNilable var starLevel: Int = .init()
        @DecodeNilable var enumValue: DataSet.Cards = .unknownCard
        @DecodeNilable var iconUrls: IconUrls = .init()
        
        enum CodingKeys: String, CodingKey {
            case name,
                 id,
                 maxLevel,
                 starLevel,
                 enumValue,
                 iconUrls
            case oldLevel = "level"
        }
        
        func populate() -> Self {
            return .init(name: self.name,
                         id: self.id,
                         oldLevel: self.oldLevel,
                         level: DTOs.CRAPI.Funcs.Card.level(oldLevel: self.oldLevel,
                                                 maxLevel: self.maxLevel),
                         maxLevel: self.maxLevel,
                         starLevel: self.starLevel,
                         enumValue: .find(id: self.id),
                         iconUrls: self.iconUrls)
        }
    }
}

extension PlayerBattle {
    struct IconUrls: Codable, EmptyInitializable {
        @DecodeNilable var medium: String = .init()
    }
}

extension PlayerBattle {
    struct Clan: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = "no clan"
        @DecodeNilable var badgeId: Int = .init()
        @DecodeNilable var badgeName: String = "no_clan"
        
        func populate() -> Self {
            return .init(tag: self.tag,
                         name: self.name == "" ? "no clan" : self.name,
                         badgeId: self.badgeId,
                         badgeName: DTOs.CRAPI.Funcs.Clan.badgeName(badgeId: self.badgeId))
        }
    }
}

extension PlayerBattle {
    struct Arena: Codable, EmptyInitializable {
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var name: String = .init()
    }
}

extension PlayerBattle {
    struct GameMode: Codable, EmptyInitializable {
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var name: String = .init()
    }
}

extension PlayerBattle {
    struct Battler: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var startingTrophies: Int = .init()
        @DecodeNilable var kingTowerHitPoints: Int = .init()
        @DecodeNilable var princessTowersHitPoints: [Int] = .init()
        @DecodeNilable var trophyChange: Int = .init()
        @DecodeNilable var crowns: Int = .init()
        @DecodeNilable var clan: Clan = .init()
        @DecodeNilable var cards: [Card] = .init()
        
        func princessTowersHitPointsHandler(hitPoints: [Int]) -> [Int] {
            if hitPoints.count == 0 { return [0, 0] }
            else if hitPoints.count == 1 { return [hitPoints[0], 0] }
            else { return hitPoints }
        }
        
        func populate() -> Self {
            return .init(tag: self.tag,
                         name: self.name,
                         startingTrophies: self.startingTrophies,
                         kingTowerHitPoints: self.kingTowerHitPoints,
                         princessTowersHitPoints:
                            princessTowersHitPointsHandler(hitPoints: self.princessTowersHitPoints),
                         trophyChange: self.trophyChange,
                         crowns: self.crowns,
                         clan: self.clan.populate(),
                         cards: self.cards.map {$0.populate()})
        }
    }
}

extension PlayerBattle {
    func populate() -> DTOs.CRAPI.PlayerBattle {
        return .init(type: self.type,
                     challengeTitle: self.challengeTitle,
                     title: DTOs.CRAPI.Funcs.Battle.title(battleName: gameMode.name,
                                               challengeTitle: self.challengeTitle,
                                               isLadderTournament: self.isLadderTournament),
                     battleTime: self.battleTime,
                     challengeWinCountBefore: self.challengeWinCountBefore,
                     isLadderTournament: self.isLadderTournament,
                     arena: self.arena,
                     gameMode: gameMode,
                     deckSelection: self.deckSelection,
                     team: self.team.map {$0.populate()},
                     opponent: self.opponent.map {$0.populate()})
    }
}

extension Array where Element == DTOs.CRAPI.PlayerBattle {
    func populate() -> Array<DTOs.CRAPI.PlayerBattle> {
        return self.map {$0.populate()}
    }
}
