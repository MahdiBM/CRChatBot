@testable import App
import XCTVapor
import Redis
import Queues

final class RedisControllerTests: XCTestCase {
    var app: Application!
    var redis: Application.Redis!
    let adminAuthenticator = Authenticators.AdminAuthenticator()
    let baseUrl = "twitch/api/v1/redis/"
    let playersLeaderboardKey = RedisKey(for: .playerLeaderboardItems)
    let minTrophyCountKey = RedisKey(for: .minimumGlobalLeaderboardTrophies)
    
    override func setUpWithError() throws {
        app = Application(.testing)
        redis = app.redis
        try Configuration(app).perform()
        // Redis requires `app.boot()` for some reasons.
        try app.boot()
        _ = try app.redis.delete([minTrophyCountKey, playersLeaderboardKey]).wait()
    }
    
    override func tearDown() {
        _ = try! app.redis.delete([minTrophyCountKey, playersLeaderboardKey]).wait()
        app.shutdown()
    }
    
    // If failed, read `## Explanation about tests which might fail without app's fault`
    // in the `TestsInfo.md` file before more investigations.
    func testRoutes() throws {
        
        // Populate redis so we can test
        let scheduleCount = 5
        for idx in 0..<scheduleCount {
            let schedule = UpdatePlayersLeaderboard(scheduleOffset: idx,
                                                    schedulesTotalCount: scheduleCount,
                                                    lifeTime: 12)
            try schedule.run(context: .init(queueName: QueueName(string: "schedule\(idx)"),
                                            configuration: QueuesConfiguration(),
                                            application: app,
                                            logger: app.logger,
                                            on: app.eventLoopGroup.next())
            ).wait()
        }
        
        var adminHeaders = HTTPHeaders()
        adminHeaders.basicAuthorization = adminAuthenticator.ultimateOwnerAdmin
        
        try app.test(.GET, baseUrl + "count", headers: adminHeaders) { res in
            // The count should be a number between 1K to 150K. (Just from my experience) 
            let number = Int(res.body.string)!
            XCTAssertTrue(number >= 1000)
            XCTAssertTrue(number <= 150000)
        }
        
        let trophies = singleTrophyNumberFromGlobalLeaderboard(app: app)
        try app.test(.GET, baseUrl + "players/\(trophies)", headers: adminHeaders) { res in
            XCTAssertContent([DTOs.Redis.Player].self, res) { content in
                XCTAssertNotEqual(content.count, 0)
                for player in content {
                    XCTAssertFalse(player.name.isEmpty)
                    XCTAssertFalse(player.tag.isEmpty)
                    XCTAssertNotEqual(player.timestamp, 0)
                    XCTAssertNotEqual(player.trophies, 0)
                }
            }
        }
        
        // /purge should delete the whole key so everything
        // saved in playersLeaderboardKey should be deleted.
        try app.test(.GET, baseUrl + "purge", headers: adminHeaders) { res in
            XCTAssertEqual(res.body.string, "1")
        }
        
        // After purge, there must be no instances left,
        // so count must be 0.
        try app.test(.GET, baseUrl + "count", headers: adminHeaders) { res in
            let number = Int(res.body.string)!
            XCTAssertEqual(number, 0)
        }
        
        // Should return unauthorized since there is no admin basic header.
        try app.test(.GET, baseUrl + "count") { res in
            XCTAssertEqual(res.status, .unauthorized)
        }
        
        // To test `/minTrophies` endpoint, we should at least once
        // hit the `/twitch/api/v1/cr` endpoint with a deck request
        // so it checks for decks and meanwhile populates
        // "minimumGlobalLeaderboardTrophies" redis key.
        // We can directly set a value to that redis key, but this approach
        // is better, since this is the actual thing that happens in production.
        try app.test(.GET, "twitch/api/v1/cr?arg1=deck&arg2=\(trophies)", headers: adminHeaders) { res in
            XCTAssertEqual(res.status, .ok)
        }
        
        // Now `/minTrophies` must return a good int where 1000 < int < 10000
        // 1000 and 10000 are just two logical numbers based on
        // how Clash Royale's trophy system works.
        try app.test(.GET, baseUrl + "minTrophies", headers: adminHeaders) { res in
            let number = Int(res.body.string)!
            XCTAssertTrue(number > 1000)
            XCTAssertTrue(number < 10000)
        }
    }
    
}
