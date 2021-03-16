import Foundation

extension DataSet {
    enum Arena {
        case arena0
        case arena1
        case arena2
        case arena3
        case arena4
        case arena5
        case arena6
        case arena7
        case arena8
        case arena9
        case arena10
        case arena11
        case arena12
        case arena13
        case arena14
        case arena15
        case arena16
        case arena17
        case arena18
        case arena19
        case arena20
        case arena21
        case arena22
        
        var imageName: String {
            switch self {
            case .arena0: return "arena0"
            case .arena1: return "arena1"
            case .arena2: return "arena2"
            case .arena3: return "arena3"
            case .arena4: return "arena4"
            case .arena5: return "arena5"
            case .arena6: return "arena6"
            case .arena7: return "arena7"
            case .arena8: return "arena8"
            case .arena9: return "arena9"
            case .arena10: return "arena10"
            case .arena11: return "arena11"
            case .arena12: return "arena12"
            case .arena13: return "arena13"
            case .arena14: return "arena14"
            case .arena15: return "arena15"
            case .arena16: return "arena16"
            case .arena17: return "arena17"
            case .arena18: return "arena18"
            case .arena19: return "arena19"
            case .arena20: return "arena20"
            case .arena21: return "arena21"
            case .arena22: return "arena22"
            }
        }
        
        static func find(trophies: Int) -> Self {
            switch trophies {
            case let x where x < 300: return .arena1
            case let x where x < 600: return .arena2
            case let x where x < 1000: return .arena3
            case let x where x < 1300: return .arena4
            case let x where x < 1600: return .arena5
            case let x where x < 2000: return .arena6
            case let x where x < 2300: return .arena7
            case let x where x < 2600: return .arena8
            case let x where x < 3000: return .arena9
            case let x where x < 3300: return .arena10
            case let x where x < 3600: return .arena11
            case let x where x < 4000: return .arena12
            case let x where x < 4300: return .arena13
            case let x where x < 4600: return .arena14
            case let x where x < 5000: return .arena15
            case let x where x < 5300: return .arena16
            case let x where x < 5600: return .arena17
            case let x where x < 6000: return .arena18
            case let x where x < 6300: return .arena19
            case let x where x < 6600: return .arena20
            case let x where x < 7000: return .arena21
            case let x where x < 100000: return .arena22
            default: return .arena0
            }
        }
        
        var arenaNumber: Int {
            switch self {
            case .arena0: return 0
            case .arena1: return 1
            case .arena2: return 2
            case .arena3: return 3
            case .arena4: return 4
            case .arena5: return 5
            case .arena6: return 6
            case .arena7: return 7
            case .arena8: return 8
            case .arena9: return 9
            case .arena10: return 10
            case .arena11: return 11
            case .arena12: return 12
            case .arena13: return 13
            case .arena14: return 14
            case .arena15: return 15
            case .arena16: return 16
            case .arena17: return 17
            case .arena18: return 18
            case .arena19: return 19
            case .arena20: return 20
            case .arena21: return 21
            case .arena22: return 22
            }
        }
    }
}
