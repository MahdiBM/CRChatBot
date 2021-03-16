import Foundation

private typealias GTInfo = DTOs.CRAPI.GTInfo

extension DTOs.CRAPI {
    typealias GTInfo = GlobalTourneyInfo
    
    struct GlobalTourneyInfo: Codable, EmptyInitializable {
        @DecodeNilable var items: [Item] = .init()
    }
}

extension GTInfo {
    struct Item: Codable, EmptyInitializable {
        @DecodeNilable var tag: String = .init()
        @DecodeNilable var gameMode: GameMode = .init()
        @DecodeNilable var maxLosses: Int = .init()
        @DecodeNilable var minExpLevel: Int = .init()
        @DecodeNilable var tournamentLevel: Int = .init()
        @DecodeNilable var title: String = .init()
        @DecodeNilable var startTime: String = .init()
        @DecodeNilable var endTime: String = .init()
        @DecodeNilable var maxTopRewardRank: Int = .init()
        @DecodeNilable var milestoneRewards: [Reward] = .init()
        @DecodeNilable var freeTierRewards: [Reward] = .init()
        @DecodeNilable var topRankReward: [Reward] = .init()
        
        func populate() -> Self {
            var model = self
            model.milestoneRewards = model.milestoneRewards.map {$0.populate()}
            model.freeTierRewards = model.freeTierRewards.map {$0.populate()}
            model.topRankReward = model.topRankReward.map {$0.populate()}
            return model
        }
    }
}

extension GTInfo {
    struct GameMode: Codable, EmptyInitializable {
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var name: String = .init()
    }
}

extension GTInfo {
    struct Reward: Codable, EmptyInitializable {
        @DecodeNilable var chest: String = .init()
        @DecodeNilable var rarity: String = .init()
        @DecodeNilable var resource: String = .init()
        @DecodeNilable var type: String = .init()
        @DecodeNilable var amount: Int = .init()
        @DecodeNilable var card: Card = .init()
        @DecodeNilable var wins: Int = .init()
        
        func populate() -> Self {
            var model = self
            model.card = model.card.populate()
            return model
        }
    }
}

extension GTInfo {
    struct Card: Codable, EmptyInitializable {
        @DecodeNilable var iconUrls: IconUrls = .init()
        @DecodeNilable var name: String = .init()
        @DecodeNilable var id: Int = .init()
        @DecodeNilable var maxLevel: Int = .init()
        @DecodeNilable var enumValue: DataSet.Cards = .unknownCard
        
        func populate() -> Self {
            return .init(iconUrls: self.iconUrls,
                         name: self.name,
                         id: self.id,
                         maxLevel: self.maxLevel,
                         enumValue: .find(id: self.id))
        }
    }
}

extension GTInfo {
    struct IconUrls: Codable, EmptyInitializable {
        @DecodeNilable var medium: String = .init()
    }
}

extension GTInfo {
    func populate() -> DTOs.CRAPI.GlobalTourneyInfo {
        return .init(items: self.items.map {$0.populate()})
    }
}
