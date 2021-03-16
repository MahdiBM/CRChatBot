import Vapor

extension TwitchResponder {
    /// Help for commands.
    func help(nextArg arg: String?) -> ELF<String> {
        // If the arg is a command name then show help for that command.
        // In that case, RequestType should be initialized successfully.
        let requestType = RequestType.find(using: arg)
        let futureString = { (str: String) -> ELF<String> in
            req.eventLoop.makeSucceededFuture(str)
        }
        switch requestType {
        case .deck: return futureString(ResponseError.help(case: .deckCommand).description)
        case .rank: return futureString(ResponseError.help(case: .rankCommand).description)
        case .set: return futureString(ResponseError.help(case: .setCommand).description)
        default: return futureString(ResponseError.help(case: .general).description)
        }
    }
}
