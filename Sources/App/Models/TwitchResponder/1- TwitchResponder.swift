import Vapor

/// The Type that responds to NightBot requests for the CR Command.
struct TwitchResponder {
    let req: Request
    let nightBot: NightBot
    let params: Params
    let isAdminReq: Bool
    
    init (req: Request) throws {
        let adminCredentials = Authenticators.AdminAuthenticator().ultimateOwnerAdmin
        let basicHeader = req.headers.basicAuthorization
        let isAdminReq = basicHeader == adminCredentials
        
        /*
         If you are trying to test as an Admin, don't forget to
         trigger the `twitch/api/v1/streamers/night/add` endpoint once,
         so `night` streamer is added to streamers in db.
         Some things won't work without the streamer being in the database.
        */
        
        let nightBot: NightBot
        if isAdminReq { // For easier access of Admins
            nightBot = .mockedValue
        } else { // If it's a non-Admin request.
            nightBot = try NightBot(headers: req.headers)
        }
        let params = try req.query.decode(Params.self)
        
        self.req = req
        self.nightBot = nightBot
        self.isAdminReq = isAdminReq
        self.params = params
    }
}

