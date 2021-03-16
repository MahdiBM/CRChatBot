import Foundation

extension DataSet.Cards {
    var subTroops: [Self] {
        switch self {
        case .battleRam: return [.barbarians]
        case .skeletonArmy: return [.skeletons]
        case .goblinGang: return [.spearGoblins, .goblins]
        case .witch: return [.skeletons]
        case .nightWitch: return [.bats]
        case .barbarianBarrel: return [.barbarians]
        case .skeletonBarrel: return [.skeletons]
        case .furnace: return [.fireSpirits]
        case .tombstone: return [.skeletons]
        case .barbarianHut: return [.barbarians]
        case .goblinBarrel: return [.goblins]
        case .graveyard: return [.skeletons]
        case .goblinHut: return [.spearGoblins]
        case .goblinGiant: return [.spearGoblins]
        default: return []
        }
    }
}

extension DataSet.Cards {
    var children: [Children] {
        switch self {
        case .rascals: return [.rascalBoy, .rascalGirls]
        case .elixirGolem: return [.elixirGolemites, .elixirBlobs]
        case .goblinCage: return [.goblinBrawler]
        case .lavaHound: return [.lavaPups]
        case .ramRider: return [.rider]
        case .golem: return [.golemites]
        default: return []
        }
    }
}

extension DataSet.Cards.Children {
    var name: String {
        switch self {
        case .rascalBoy: return "Rascal Boy"
        case .rascalGirls: return "Rascal Girl"
        case .elixirGolemites: return "Elixir Golemites"
        case .elixirBlobs: return "Elixir Blobs"
        case .goblinBrawler: return "Goblin Brawler"
        case .lavaPups: return "Lava Pups"
        case .rider: return "Rider"
        case .golemites: return "Golemites"
        case .cursedHog: return "Cursed Hog"
        }
    }
    
    var key: String {
        switch self {
        case .rascalBoy: return "rascal-boy"
        case .rascalGirls: return "rascal-girl"
        case .elixirGolemites: return "elixir-golemite"
        case .elixirBlobs: return "elixir-blob"
        case .goblinBrawler: return "goblin-brawler"
        case .lavaPups: return "lava-pup"
        case .rider: return "rider"
        case .golemites: return "golemite"
        case .cursedHog: return "cursde-hog"
        }
    }
}
