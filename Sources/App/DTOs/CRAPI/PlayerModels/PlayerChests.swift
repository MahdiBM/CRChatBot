import Foundation

extension DTOs.CRAPI {
    struct PlayerChests: Codable, EmptyInitializable {
        @DecodeNilable var items: [Chest] = .init()
    }
}

extension DTOs.CRAPI.PlayerChests {
    struct Chest: Codable, EmptyInitializable {
        @DecodeNilable var index: Int = .init()
        @DecodeNilable var name: String = .init()
    }
}

