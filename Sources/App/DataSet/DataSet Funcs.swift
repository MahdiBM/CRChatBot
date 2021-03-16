import Foundation

extension DataSet.CardRarity {
    var int: Int {
        switch self {
        case .common: return 1
        case .rare: return 2
        case .epic: return 3
        case .legendary: return 4
        }
    }
    
    var cardCountNeededToMaxOne: Int {
        switch self {
        case .common: return 9586
        case .rare: return 2586
        case .epic: return 386
        case .legendary: return 36
        }
    }
    
    static func cardCountNeededToMaxAll(for rarity: Self) -> Int {
        let allCards = DataSet.Cards.allValids
        let filteredBy: (DataSet.CardRarity) -> ([DataSet.Cards]) = { rarity in
            return allCards.filter{$0.info.rarity == rarity}
        }
        switch rarity {
        case .common: return common.cardCountNeededToMaxOne * filteredBy(.common).count
        case .rare: return rare.cardCountNeededToMaxOne * filteredBy(.rare).count
        case .epic: return epic.cardCountNeededToMaxOne * filteredBy(.epic).count
        case .legendary: return legendary.cardCountNeededToMaxOne * filteredBy(.legendary).count
        }
    }
}

extension DataSet.Cards {
    static func find(id: Int) -> Self {
        let cards = DataSet.Cards.allCases
        return cards.first { $0.info.id == id } ?? .unknownCard
    }
}

extension DataSet.ClanBadge {
    static func find(badgeName: String) -> Self {
        return Self.all.first{$0.name == badgeName} ?? .noClan
    }
    
    static func find(badgeId: Int) -> Self {
        return Self.all.first{$0.id == badgeId} ?? .noClan
    }
}

extension DataSet.Regions {
    static func find(name: String?) -> Self {
        return Self.allCases.first{$0.value.name == name} ?? .All
    }
    
    static func find(key: String?) -> Self {
        return Self.allCases.first{$0.value.key == key} ?? .All
    }
    
    static func find(id: Int?) -> Self {
        return Self.allCases.first{$0.value.id == id} ?? .All
    }
}
