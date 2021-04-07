import Vapor

extension TwitchResponder {
    /// Decides if a NightBot request is valid.
    func validateRequest() -> ELF<Void> {
        let channelName = nightBot.twitchChannel.name.lowercased()
        
        let streamer = Streamers.query(on: req.db)
            .filter(\.$channelName, .equal, channelName)
            .first()
            .unwrap(or: Responses.notWhitelisted)
        
        return streamer.tryFlatMap { streamer -> ELF<Void> in
            if streamer.performOnlineChecks == false {
                return req.eventLoop.future(())
            }
            else {
                // If streamer has been online in the past 30 minutes,
                // then you don't need to check to make sure they're online
                // (this makes the command work better and faster)
                // otherwise check for them being online,
                // and only serve if they are online.
                let lastOnlineDate = Date(timeIntervalSince1970: .init(streamer.lastOnline))
                let expirationDate = Date().addingTimeInterval(.init(30 * 60))
                if lastOnlineDate > Date() && lastOnlineDate < expirationDate {
                    throw Responses.notOnline
                } else {
                    // Else, check and make sure streamer is online.
                    return doChannelOnlineCheck(streamer: streamer, channelName: channelName)
                }
            }
        }
    }
}

private extension TwitchResponder {
    /// Checks whether a streamer is online.
    func doChannelOnlineCheck(streamer: Streamers, channelName: String) -> ELF<Void> {
        TwitchRoutes.isChannelLive(req, name: channelName)
            .tryFlatMap { isOnline -> ELF<Void> in
                if isOnline == true {
                    // Save the new `.lastOnline` value to db.
                    streamer.lastOnline = .init(Date().timeIntervalSince1970)
                    return streamer.save(on: req.db)
                } else {
                    throw Responses.notOnline
                }
            }
    }
}
