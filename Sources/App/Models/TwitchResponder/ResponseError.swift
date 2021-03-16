import Vapor

extension TwitchResponder {
    /// NightBot user-friendly Errors.
    enum ResponseError: Error {
        
        /*
         For cases that have an `errorId` parameter,
         Error id is just a number to help find where the problem occurred.
         */
        
        case help(case: HelpCases)
        case noInput
        case invalidCommand
        case contact
        case noNightBot
        case notWhitelisted
        case notOnline
        case failedToCommunicateWithCRAPI(errorId: Int)
        case noResults
        // Error id is just a number to
        // help me where the problem occurred.
        case unknownFailure(errorId: Int)
        case streamerOrModNeeded
        case custom(_ message: String)
        
        var description: String {
            let help = { (helpCase: HelpCases) -> String in
                helpCase.description
            }
            let noInput = "No Input. " + help(.general)
            let invalidCommand = "Invalid command. " + help(.general)
            let contact = "You can contact me on Twitch, Twitter or Telegram"
                + " @MahdiMMBM or on Discord @Mahdi BM#0517."
            let noNightBot = "These set of commands are only available "
                + "on Twitch through NightBot."
            let notWhitelisted = "This channel is not on white-list."
                + " Please contact me on Twitch, Twitter or Telegram @MahdiMMBM"
                + " or on Discord @Mahdi BM#0517 and i will likely"
                + " white-list your channel at no costs of any kind."
            let notOnline = "Channel seems to be offline."
            let failedToCommunicateWithCRAPI = { (errorId: Int) -> String in
                "Something went wrong while"
                    + " communicating with the Official Clash Royale API."
                    + " Please make sure your inputs are correct."
                    + " No. \(errorId)"
            }
            let noResults = "Could not find any results for your request."
            let streamerOrModNeeded = "Only channel Owner or Moderators can do this."
            let unknownFailure = { (errorId: Int) -> String in
                "An unexpected error occurred."
                    + " No. \(errorId)"
            }
            
            switch self {
            case .help(let helpCase): return help(helpCase)
            case .noInput: return noInput
            case .invalidCommand: return invalidCommand
            case .contact: return contact
            case .noNightBot: return noNightBot
            case .notWhitelisted: return notWhitelisted
            case .notOnline: return notOnline
            case .failedToCommunicateWithCRAPI(let errorId):
                return failedToCommunicateWithCRAPI(errorId)
            case .noResults: return noResults
            case .unknownFailure(let errorId):
                return unknownFailure(errorId)
            case .streamerOrModNeeded: return streamerOrModNeeded
            case .custom(let message): return message
            }
        }
    }
}

extension TwitchResponder.ResponseError {
    enum HelpCases {
        case general
        case deckCommand
        case rankCommand
        case setCommand
        
        fileprivate var description: String {
            switch self {
            case .general: return "Supported commands:"
                + " —— Player Deck: `!cr deck [TROPHIES]`"
                + " —— Player Rank: `!cr rank [EMPTY or TAG]`"
                + " —— Set Streamer Info: `!cr set [\"name\"/\"tag\"] [VALUE]`"
                + " —— Contact Info: `!cr contact`"
            case .deckCommand: return "Help for `!cr deck` command. You can search for top ~10K"
                + " players' deck, knowing their trophies. Example: `!cr deck 6592`. You can"
                + " filter names too; Example: `!cr deck 6483 morten`. You can filter based on"
                + " mandarin, arabic, latin and russian as well; Example: `!cr deck 6874 mandarin`."
            case .rankCommand: return "Help for `!cr rank` command. You can get streamer's rank"
                + " using `!cr rank`, and you get rank of any player using their"
                + " player tag like so: `!cr rank [PLAYER_TAG]` (no `#` needed)."
            case .setCommand: return "Help for `!cr set` command. Currently mods can set values"
                + " for `name` or `tag` of streamer. Example: `!cr"
                + " set name Mahdi The Goat` or `!cr set tag VPU8G`."
                + " Do NOT include `#` for player tag."
            }
        }
    }
}
