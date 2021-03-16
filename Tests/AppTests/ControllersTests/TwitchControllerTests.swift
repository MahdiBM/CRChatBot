@testable import App
import XCTVapor

final class TwitchControllerTests: XCTestCase {
    var app: Application!
    var oauthToken: OAuthTokens!
    let twitch = OAuth.twitch
    let baseUrl = "twitch/api/v1/"
    let tokenPath = "/Tests/TestabilityResources/OAuthableTestToken.txt"
    let fileManager = FileManager()
    let adminAuthenticator = Authenticators.AdminAuthenticator()
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try Configuration(app).perform()
        oauthToken = OAuthableTests.getOAuthTokenFromThePersistentFile()
    }
    
    override func tearDown() {
        app.shutdown()
    }
    
    // If failed, read `## Explanation about tests which might fail without app's fault`
    // in the `TestsInfo.md` file before more investigations.
    func testOtherRoutes() throws {
        
        do {
            // This is not doing any `test` actions; only making sure the token
            // we have is a new and refreshed one. `renewTokenIfExpired(_:token:)`
            // function is tested in `OAuthableTests`.
            let request = Request(application: app, on: app.eventLoopGroup.next())
            let refreshedToken = try twitch
                .renewTokenIfExpired(request, token: oauthToken).wait()
            
            oauthToken = refreshedToken
            // Save the refreshed token to the persistent file.
            try fileManager.saveAsJSONString(refreshedToken, relativePath: tokenPath)
        }
        
        // Test `TwitchController.getATwitchAccessToken(_:)`.
        do {
            // Saving the token on db.
            _ = try oauthToken.save(on: app.db).wait()
            
            // Now the new token must be the same one as the one we saved to the db.
            let request = Request(application: app, on: app.eventLoopGroup.next())
            let newToken = try TwitchRoutes.getATwitchAccessToken(request).wait()!
            
            XCTAssertEqual(oauthToken.accessToken, newToken.accessToken)
            XCTAssertEqual(oauthToken.expiresIn, newToken.expiresIn)
            XCTAssertEqual(oauthToken.createdAt, newToken.createdAt)
            XCTAssertEqual(oauthToken.id, newToken.id)
            XCTAssertEqual(oauthToken.issuer, newToken.issuer)
            XCTAssertEqual(oauthToken.refreshToken, newToken.refreshToken)
            XCTAssertEqual(oauthToken.scope, newToken.scope)
            XCTAssertEqual(oauthToken.streamerId, newToken.streamerId)
            XCTAssertEqual(oauthToken.tokenType, newToken.tokenType)
        }
        
        // Test `TwitchController.search(_:using:)`.
        do {
            let request = Request(application: app, on: app.eventLoopGroup.next())
            let search = try TwitchRoutes.search(request, using: "boss").wait()!
            let searchResults = search.data
            XCTAssertNotEqual(searchResults.count, 0)
            searchResults.forEach { channel in
                XCTAssertTrue(channel.displayName.lowercased().contains("boss"))
            }
        }
        
        // Test `TwitchController.isChannelLive(_:name:)`.
        do {
            let request = Request(application: app, on: app.eventLoopGroup.next())
            let channelIsLive = try TwitchRoutes.isChannelLive(request, name: "night").wait()
            XCTAssertNotNil(channelIsLive)
            
            // Just to check if the function works and doesn't throw an error.
            XCTAssertNoThrow(try TwitchRoutes.isChannelLive(request, name: "ninja").wait())
        }
        
    }
    
    // If failed, read `## Explanation about tests which might fail without app's fault`
    // in the `TestsInfo.md` file before more investigations.
    func testCRCommandRouteAsAdmin() throws {
        var adminHeaders = HTTPHeaders()
        adminHeaders.basicAuthorization = adminAuthenticator.ultimateOwnerAdmin
        
        // Add `nightbot` as a channel since the endpoint
        // needs a value of type `Streamers` to work with.
        try app.test(.GET, "twitch/api/v1/streamers/night/add", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, [:])
                XCTAssertEqual(streamer.isBlacklisted, false)
                XCTAssertEqual(streamer.performOnlineChecks, true)
                XCTAssertEqual(streamer.lastOnline, 0)
            }
        }
        
        // Tests `!cr deck [Trophies]`/`!cr decks [Trophies]`
        let trophies = singleTrophyNumberFromGlobalLeaderboard(app: app)
        for firstArg in ["deck", "decks"] {
            try app.test(.GET, baseUrl + "cr?arg1=\(firstArg)&arg2=\(trophies)",
                         headers: adminHeaders) { res in
                XCTAssertEqual(res.status, .ok)
                // Below here is logic to make sure the process has gone successfully
                // and the response contains at least a name with deck string.
                XCTAssertContains(res.body.string, ": ")
                let componentsSeparatedByCardNames = res.body.string.components(separatedBy: ", ")
                XCTAssertTrue(componentsSeparatedByCardNames.count >= 8)
            }
        }
        
        // Tests `!cr rank`. Receives a failure string because
        // at this point streamerTag/streamerName are not set yet.
        try app.test(.GET, baseUrl + "cr?arg1=rank", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night You need to first set streamer name"
                            + " using command '!cr set name STREAMER_NAME_HERE' and"
                            + " set streamer tag using command '!cr set tag"
                            + " STREAMER_TAG_HERE'. MUST NOT CONTAIN '#'")
        }
        
        // Tests `!cr rank [tag]`
        try app.test(.GET, baseUrl + "cr?arg1=rank&arg2=C0G20PR2", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContains(res.body.string, "/me @night 'SML' is currently ranked ")
            XCTAssertContains(res.body.string, " globally, with ")
            XCTAssertContains(res.body.string, " 🏆. His current season best is ")
        }
        
        // Tests `!cr set name [Name]`
        try app.test(.GET, baseUrl + "cr?arg1=set&arg2=name&arg3=CWA", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Successfully set value"
                            + " of 'Streamer Name' to 'CWA'")
        }
        
        // Tests `!cr set tag [Tag]`
        try app.test(.GET, baseUrl + "cr?arg1=set&arg2=tag&arg3=VPU8G", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Successfully set value of"
                            + " 'Streamer Tag' to 'VPU8G'")
        }
        
        // Tests `!cr rank`.
        // Doesn't fail because streamerTag/streamerName are set.
        try app.test(.GET, baseUrl + "cr?arg1=rank", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContains(res.body.string, "/me @night CWA is currently ranked ")
            XCTAssertContains(res.body.string, " globally, with ")
            XCTAssertContains(res.body.string, " 🏆. His current season best is ")
        }
        
        // Tests `!cr help`
        try app.test(.GET, baseUrl + "cr?arg1=help", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Supported commands: —— Player Deck:"
                            + " `!cr deck [TROPHIES]` —— Player Rank: `!cr rank [EMPTY or TAG]`"
                            + " —— Set Streamer Info: `!cr set [\"name\"/\"tag\"] [VALUE]`"
                            + " —— Contact Info: `!cr contact`")
        }
        
        // Tests `!cr help deck`
        try app.test(.GET, baseUrl + "cr?arg1=help&arg2=rank", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Help for `!cr rank` command. You can get"
                            + " streamer's rank using `!cr rank`, and you get rank of any player"
                            + " using their player tag like so: `!cr rank [PLAYER_TAG]` (no `#` needed).")
        }
        
        // Tests `!cr contact`
        try app.test(.GET, baseUrl + "cr?arg1=contact", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night You can contact me on Twitch, Twitter"
                            + " or Telegram @MahdiMMBM or on Discord @Mahdi BM#0517.")
        }
        
        // Commands should work non-case-sensitively:
        try app.test(.GET, baseUrl + "cr?arg1=COnTAcT", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night You can contact me on Twitch, Twitter"
                            + " or Telegram @MahdiMMBM or on Discord @Mahdi BM#0517.")
        }
        
        // Tests `!cr [Any_Invalid_Word]`
        try app.test(.GET, baseUrl + "cr?arg1=lsljdai", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Invalid command. Supported commands: —— Player"
                            + " Deck: `!cr deck [TROPHIES]` —— Player Rank: `!cr rank [EMPTY or TAG]`"
                            + " —— Set Streamer Info: `!cr set [\"name\"/\"tag\"] [VALUE]` —— Contact"
                            + " Info: `!cr contact`")
        }
        
        // Tests `!cr`
        try app.test(.GET, baseUrl + "cr", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Invalid command. Supported commands: —— Player"
                            + " Deck: `!cr deck [TROPHIES]` —— Player Rank: `!cr rank [EMPTY or TAG]`"
                            + " —— Set Streamer Info: `!cr set [\"name\"/\"tag\"] [VALUE]` —— Contact"
                            + " Info: `!cr contact`")
        }
        
        // Tests `!cr` while there is no basic authorization.
        try app.test(.GET, baseUrl + "cr") { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "These set of commands are only"
                            + " available on Twitch through NightBot.")
        }
        
    }
    
    // If failed, read `## Explanation about tests which might fail without app's fault`
    // in the `TestsInfo.md` file before more investigations.
    func testCRCommandRouteAsNightBotRequest() throws {
        
        let nbUser = "name=night&displayName=night&provider=twitch&providerId=11785491&userLevel=owner"
        let nbChannel = "name=night&displayName=Night&provider=twitch&providerId=11785491"
        let nbUrl = "https://api.nightbot.tv/1/channel/send/TVRRM05UazRNVGsyT1RnNE1TOWthWE5"
        let nightBotHeaders = HTTPHeaders([
            ("Nightbot-User", nbUser),
            ("Nightbot-Channel", nbChannel),
            ("Nightbot-Response-Url", nbUrl)
        ])
        
        var adminHeaders = HTTPHeaders()
        adminHeaders.basicAuthorization = adminAuthenticator.ultimateOwnerAdmin
        
        // Add `nightbot` as a channel since the endpoint
        // needs a value of type `Streamers` to work with.
        try app.test(.GET, "twitch/api/v1/streamers/night/add", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, [:])
                XCTAssertEqual(streamer.isBlacklisted, false)
                XCTAssertEqual(streamer.performOnlineChecks, true)
                XCTAssertEqual(streamer.lastOnline, 0)
            }
        }
        
        // Turn online checks off, since we cant yet make requests
        // to Twitch API in tests to check for channel online/offline
        try app.test(.GET, "twitch/api/v1/streamers/night/toggleOnlineChecks",
                     headers: adminHeaders) { res in
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, [:])
                XCTAssertEqual(streamer.isBlacklisted, false)
                XCTAssertEqual(streamer.performOnlineChecks, false)
                XCTAssertEqual(streamer.lastOnline, 0)
                XCTAssertNotNil(streamer.createdAt)
            }
        }
        
        // Tests `!cr deck [Trophies]`/`!cr decks [Trophies]`
        let trophies = singleTrophyNumberFromGlobalLeaderboard(app: app)
        for firstArg in ["deck", "decks"] {
            try app.test(.GET, baseUrl + "cr?arg1=\(firstArg)&arg2=\(trophies)",
                         headers: nightBotHeaders) { res in
                XCTAssertEqual(res.status, .ok)
                // Below here is logic to make sure the process has gone successfully
                // and the response contains at least a name with deck string.
                XCTAssertContains(res.body.string, ": ")
                let componentsSeparatedByCardNames = res.body.string.components(separatedBy: ", ")
                XCTAssertTrue(componentsSeparatedByCardNames.count >= 8)
            }
        }
        
        // Tests `!cr rank`. Receives a failure string because
        // at this point streamerTag/streamerName are not set yet.
        try app.test(.GET, baseUrl + "cr?arg1=rank", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night You need to first set streamer name"
                            + " using command '!cr set name STREAMER_NAME_HERE' and"
                            + " set streamer tag using command '!cr set tag"
                            + " STREAMER_TAG_HERE'. MUST NOT CONTAIN '#'")
        }
        
        // Tests `!cr rank [tag]`
        try app.test(.GET, baseUrl + "cr?arg1=rank&arg2=C0G20PR2", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContains(res.body.string, "/me @night 'SML' is currently ranked ")
            XCTAssertContains(res.body.string, " globally, with ")
            XCTAssertContains(res.body.string, " 🏆. His current season best is ")
        }
        
        // Tests `!cr set name [Name]`
        try app.test(.GET, baseUrl + "cr?arg1=set&arg2=name&arg3=CWA", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Successfully set value"
                            + " of 'Streamer Name' to 'CWA'")
        }
        
        // Tests `!cr set tag [Tag]`
        try app.test(.GET, baseUrl + "cr?arg1=set&arg2=tag&arg3=VPU8G", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Successfully set value of"
                            + " 'Streamer Tag' to 'VPU8G'")
        }
        
        // Tests `!cr rank`.
        // Doesn't fail because streamerTag & streamerName are set.
        try app.test(.GET, baseUrl + "cr?arg1=rank", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContains(res.body.string, "/me @night CWA is currently ranked ")
            XCTAssertContains(res.body.string, " globally, with ")
            XCTAssertContains(res.body.string, " 🏆. His current season best is ")
        }
        
        // Tests `!cr help`
        try app.test(.GET, baseUrl + "cr?arg1=help", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Supported commands: —— Player Deck:"
                            + " `!cr deck [TROPHIES]` —— Player Rank: `!cr rank [EMPTY or TAG]`"
                            + " —— Set Streamer Info: `!cr set [\"name\"/\"tag\"] [VALUE]`"
                            + " —— Contact Info: `!cr contact`")
        }
        
        // Tests `!cr help deck`
        try app.test(.GET, baseUrl + "cr?arg1=help&arg2=rank", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Help for `!cr rank` command. You can get"
                            + " streamer's rank using `!cr rank`, and you get rank of any player"
                            + " using their player tag like so: `!cr rank [PLAYER_TAG]` (no `#` needed).")
        }
        
        // Tests `!cr contact`
        try app.test(.GET, baseUrl + "cr?arg1=contact", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night You can contact me on Twitch, Twitter"
                            + " or Telegram @MahdiMMBM or on Discord @Mahdi BM#0517.")
        }
        
        // Commands should work non-case-sensitively:
        try app.test(.GET, baseUrl + "cr?arg1=COnTAcT", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night You can contact me on Twitch, Twitter"
                            + " or Telegram @MahdiMMBM or on Discord @Mahdi BM#0517.")
        }
        
        // Tests `!cr [Any_Invalid_Word]`
        try app.test(.GET, baseUrl + "cr?arg1=lsljdai", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Invalid command. Supported commands: —— Player"
                            + " Deck: `!cr deck [TROPHIES]` —— Player Rank: `!cr rank [EMPTY or TAG]`"
                            + " —— Set Streamer Info: `!cr set [\"name\"/\"tag\"] [VALUE]` —— Contact"
                            + " Info: `!cr contact`")
        }
        
        // Tests `!cr`
        try app.test(.GET, baseUrl + "cr", headers: nightBotHeaders) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "/me @night Invalid command. Supported commands: —— Player"
                            + " Deck: `!cr deck [TROPHIES]` —— Player Rank: `!cr rank [EMPTY or TAG]`"
                            + " —— Set Streamer Info: `!cr set [\"name\"/\"tag\"] [VALUE]` —— Contact"
                            + " Info: `!cr contact`")
        }
        
        // Tests `!cr` while there are no night bot headers.
        try app.test(.GET, baseUrl + "cr") { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "These set of commands are only"
                            + " available on Twitch through NightBot.")
        }
        
    }
    
}
