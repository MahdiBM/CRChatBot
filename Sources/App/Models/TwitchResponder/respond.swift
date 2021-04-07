import Vapor

extension TwitchResponder {
    /// Responds to the request.
    func respond() -> ELF<String> {
        let requestType = RequestType.find(using: params.arg1)
        return serveRequest(for: requestType)
    }
}

//MARK: - Serve Request

private extension TwitchResponder {
    /// Serve the request.
    func serveRequest(for requestType: RequestType) -> ELF<String> {
        let validation: ELF<Void> = {
            switch isAdminReq {
            case true: // No validation needed for a request from an Admin.
                return req.eventLoop.future(())
            case false:
                return validateRequest()
            }
        }()
        let saveReq = validation.map { _ in requestType }
            .flatMap(saveRequest)
        let answerTheRequest = saveReq.map { _ in requestType  }
            .tryFlatMap(callCorrespondingFuncs)
        let responseString = makeResponseString(for: answerTheRequest)
        return responseString
    }
    
    /// Calls the appropriate funcs for each case of RequestType.
    func callCorrespondingFuncs(for requestType: RequestType) throws -> ELF<String> {
        switch requestType {
        case .deck:
            guard let trophies = try? Int(params.arg2.throwingUnwrap()) else {
                throw Responses.help(case: .deckCommand)
            }
            let theRest = params.theRest(startingFrom: \Params.arg3)
            return findDeck(using: trophies, filterBy: theRest)
        case .rank:
            return findRank(preferredTag: params.arg2)
        case .set:
            guard let key = params.arg2,
                  let theRest = params.theRest(startingFrom: \Params.arg3) else {
                throw Responses.help(case: .setCommand)
            }
            return try setInfo(key: key, value: theRest)
        case .help: return help(nextArg: params.arg2)
        case .contact: throw Responses.contact
        case .unknown: throw Responses.invalidCommand
        }
    }
    
    /// Save a little bit of info about the request to the database for analysis purposes.
    func saveRequest(for requestType: RequestType) -> ELF<Void> {
        let description = requestType.rawValue
        let channelName = nightBot.twitchChannel.name.lowercased()
        
        let streamer = Streamers.query(on: req.db)
            .filter(\.$channelName, .equal, channelName)
            .first()
        
        // Save a new UserRequest to db.
        let saveRequest = streamer.flatMap { streamer -> ELF<Void> in
            if let streamer = streamer,
               let streamerId = streamer.id {
                let request = UserRequests
                    .init(streamerId: streamerId,
                          username: nightBot.twitchUser?.displayName ?? "UNKNOWN",
                          timestamp: Int(Date().timeIntervalSince1970),
                          description: description)
                return request.save(on: req.db)
            }
            else {
                // Don't throw errors if somehow someway streamer is not in the db already.
                return req.eventLoop.future(())
            }
        }
        
        return saveRequest
    }
    
    /// Makes the final response, taking care of the errors,
    /// and adding twitch-chat-specific properties to the response String.
    func makeResponseString(for event: ELF<String>) -> ELF<String> {
        let response = event.map { responseString($0) }
            // To take care of `throw`s which might have happened in the process.
            // Actual errors that are not a straight string
            // have no use for NightBot users and rather create a bad UX.
        let errorsHandled = response.flatMapErrorThrowing { error in
            if let twitchResponderError = error as? Responses {
                return responseString(twitchResponderError.description)
            } else {
                return responseString(.unknownFailure(errorId: 90482, description: error.localizedDescription))
            }
        }
        
        return errorsHandled
    }
}


//MARK: -Final-String Makers

private extension TwitchResponder {
    /// Returns a string which is ready to be passed as a NightBot response.
    func responseString(_ str: String) -> String {
        let mentioned: String
        switch nightBot.twitchUser?.displayName {
        case let name?: mentioned = "@" + name + " "
        default: mentioned = ""
        }
        let string = "/me " + mentioned + str
        return string
    }
    
    /// Returns a string which is ready to be passed as a NightBot response.
    func responseString(_ message: Responses) -> String {
        responseString(message.description)
    }
    
    /// Returns a ELF<String> which is ready to be passed as a NightBot response.
    func futureString(_ str: String) -> ELF<String> {
        let response = responseString(str)
        return req.eventLoop.future(response)
    }
    
    /// Returns a ELF<String> which is ready to be passed as a NightBot response.
    func futureString(_ message: Responses) -> ELF<String> {
        futureString(message.description)
    }
}

