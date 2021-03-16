import Foundation

private typealias PlayerProfile = DTOs.CRAPI.PlayerProfile

extension DTOs.CRAPI {
    struct PlayerProfile: Codable, EmptyInitializable {
        
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var expLevel: Int = .init()
        @DecodeNilable var starPoints: Int = .init()
        @DecodeNilable var trophies: Int = .init()
        @DecodeNilable var bestTrophies: Int = .init()
        @DecodeNilable var wins: Int = .init()
        @DecodeNilable var losses: Int = .init()
        @DecodeNilable var battleCount: Int = .init()
        @DecodeNilable var threeCrownWins: Int = .init()
        @DecodeNilable var challengeCardsWon: Int = .init()
        @DecodeNilable var challengeMaxWins: Int = .init()
        @DecodeNilable var tournamentCardsWon: Int = .init()
        @DecodeNilable var tournamentBattleCount: Int = .init()
        @DecodeNilable var role: String = .init()
        @DecodeNilable var donations: Int = .init()
        @DecodeNilable var donationsReceived: Int = .init()
        @DecodeNilable var totalDonations: Int = .init()
        @DecodeNilable var warDayWins: Int = .init()
        @DecodeNilable var clanCardsCollected: Int = .init()
        @DecodeNilable var clan: Clan = .init()
        @DecodeNilable var arena: Arena = .init()
        @DecodeNilable var leagueStatistics: LeagueStatistics = .init()
        @DecodeNilable var badges: [Badge] = .init()
        @DecodeNilable var achievements: [Achievement] = .init()
        @DecodeNilable var cards: [ProfileCard] = .init()
        @DecodeNilable var currentDeck: [ProfileCard] = .init()
        @DecodeNilable var currentFavouriteCard: Card = .init()
    }
}

extension PlayerProfile {
    struct Card: Codable, EmptyInitializable {
        @DecodeNilable var name: String = .init()
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var maxLevel: Int = .init()
        @DecodeNilable var enumValue: DataSet.Cards = .unknownCard
        @DecodeNilable var iconUrls: IconUrls = .init()
        
        func populate() -> Self {
            return .init(name: self.name,
                         id: self.id,
                         maxLevel: self.maxLevel,
                         enumValue: .find(id: self.id),
                         iconUrls: self.iconUrls)
        }
    }
}

extension PlayerProfile {
    struct ProfileCard: Codable, EmptyInitializable {
        @DecodeNilable var name: String = .init()
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var level: Int = .init()
        @DecodeNilable var oldLevel: Int = .init()
        @DecodeNilable var maxLevel: Int = .init()
        @DecodeNilable var starLevel: Int = .init()
        @DecodeNilable var count: Int = .init()
        @DecodeNilable var isMaxed: Bool = .init()
        @DecodeNilable var progressText: String = .init()
        @DecodeNilable var isReadyToUpgrade: Bool = .init()
        @DecodeNilable var upgradeIsPossibleAtThisCardCount: Int = .init()
        @DecodeNilable var upgradeableToLevel: Int = .init()
        @DecodeNilable var enumValue: DataSet.Cards = .unknownCard
        @DecodeNilable var iconUrls: IconUrls = .init()
        
        enum CodingKeys: String, CodingKey {
            case name,
                 id,
                 maxLevel,
                 starLevel,
                 count,
                 iconUrls
            case oldLevel = "level"
        }
        
        func populate() -> Self {
            typealias Card = DTOs.CRAPI.Funcs.Card

            let enumValue: DataSet.Cards = .find(id: self.id)
            let level = Card.level(oldLevel: self.oldLevel,
                                   maxLevel: self.maxLevel)
            let upgradeIsPossibleAtThisCardCount = Card.upgradeIsPossibleAtThisCardCount(rarity: enumValue.info.rarity,
                                                         oldLevel: self.oldLevel)

            return .init(name: self.name,
                         id: self.id,
                         level: level,
                         oldLevel: self.oldLevel,
                         maxLevel: self.maxLevel,
                         starLevel: self.starLevel,
                         count: self.count,
                         isMaxed: Card.isMaxed(oldLevel: self.oldLevel,
                                                     maxLevel: self.maxLevel),
                         progressText: Card.progressText(count: self.count,
                                                         level: level,
                                                         rarity: enumValue.info.rarity),
                         isReadyToUpgrade: Card.isReadyToUpgrade(count: self.count,
                                                               upgradeIsPossibleAtThisCardCount: upgradeIsPossibleAtThisCardCount),
                         upgradeIsPossibleAtThisCardCount: upgradeIsPossibleAtThisCardCount,
                         upgradeableToLevel: Card.upgradeableToLevel(rarity: enumValue.info.rarity,
                                                                     count: self.count,
                                                                     level: level),
                         enumValue: enumValue,
                         iconUrls: self.iconUrls)
        }
    }
}

extension PlayerProfile {
    struct Achievement: Codable, EmptyInitializable {
        @DecodeNilable var name: String = .init()
        @DecodeNilable var stars: Int = .init()
        @DecodeNilable var value: Int = .init()
        @DecodeNilable var target: Int = .init()
        @DecodeNilable var info: String = .init()
        @DecodeNilable var completionInfo: String = .init()
    }
}

extension PlayerProfile {
    struct IconUrls: Codable, EmptyInitializable {
        @DecodeNilable var medium: String = .init()
    }
}

extension PlayerProfile {
    struct Badge: Codable, EmptyInitializable {
        @DecodeNilable var name: String = .init()
        @DecodeNilable var progress: Int = .init()
    }
}

extension PlayerProfile {
    struct Clan: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var name: String = "no clan"
        @DecodeNilable var badgeId: Int = .init()
        @DecodeNilable var badgeName: String = .init()
        
        func populate() -> Self {
            return .init(tag: self.tag,
                         name: self.name,
                         badgeId: self.badgeId,
                         badgeName: DTOs.CRAPI.Funcs.Clan.badgeName(badgeId: self.badgeId))
        }
    }
}

extension PlayerProfile {
    struct Arena: Codable, EmptyInitializable {
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var name: String = .init()
    }
}

extension PlayerProfile {
    struct LeagueStatistics: Codable, EmptyInitializable {
        @DecodeNilable var currentSeason: SeasonStats = .init()
        @DecodeNilable var previousSeason: SeasonStats = .init()
        @DecodeNilable var bestSeason: SeasonStats = .init()
    }
}

extension PlayerProfile {
    struct SeasonStats: Codable, EmptyInitializable {
        @DecodeNilable var id: String = .init()
        @DecodeNilable var trophies: Int = .init()
        @DecodeNilable var bestTrophies: Int = .init()
        @DecodeNilable var rank: Int = .init()
    }
}

extension PlayerProfile {
    func populate() -> DTOs.CRAPI.PlayerProfile {
        
        var model = self
        model.cards = model.cards.map {$0.populate()}
        model.clan = self.clan.populate()
        model.cards = model.cards.map {$0.populate()}
        model.currentDeck = model.currentDeck.map {$0.populate()}
        model.currentFavouriteCard = model.currentFavouriteCard.populate()
        
        return model
    }
}


