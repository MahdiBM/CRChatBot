import Vapor

extension TwitchResponder {
    /// Types of requests that the app can serve for NightBot.
    enum RequestType: String, CaseIterable {
        case deck
        case rank
        case set
        case help
        case contact
        case unknown
        
        /// Acceptable first arguments that users can pass to NightBot.
        /// All lowercase.
        private var correspondingValues: [String] {
            switch self {
            case .deck: return ["deck", "decks"]
            case .rank: return ["rank"]
            case .set: return ["set"]
            case .help: return ["help"]
            case .contact: return ["contact"]
            case .unknown: return []
            }
        }
        
        /// Initializes self using the first argument that user passed to NightBot.
        static func find(using firstArgument: String?) -> Self {
            guard let firstArgument = firstArgument else {
                return .unknown
            }
            return Self.allCases.first {
                $0.correspondingValues.contains(firstArgument.lowercased())
            } ?? .unknown
        }
    }
}
