import Vapor

extension TwitchResponder {
    /// Help for commands.
    func help(nextArg arg: String?) -> ELF<String> {
        // If the arg is a command name then show help for that command.
        // In that case, RequestType should be initialized successfully.
        let requestType = RequestType.find(using: arg)
        let error: Responses
        switch requestType {
        case .deck: error = Responses.help(case: .deckCommand)
        case .rank: error = Responses.help(case: .rankCommand)
        case .set: error = Responses.help(case: .setCommand)
        default: error = Responses.help(case: .general)
        }
        
        return req.eventLoop.future(error.description)
    }
}
