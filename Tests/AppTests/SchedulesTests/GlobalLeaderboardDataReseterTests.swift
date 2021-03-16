@testable import App
import XCTVapor
import Redis
import Queues

final class GlobalLeaderboardDataReseterTests: XCTestCase {
    var app: Application!
    var redis: Application.Redis!
    let adminAuthenticator = Authenticators.AdminAuthenticator()
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
    func testSchedule() throws {
        
        // Populate redis so we can test
        let scheduleCount = 5
        for idx in 0..<scheduleCount {
            let schedule = UpdatePlayersLeaderboard(scheduleOffset: idx,
                                                    schedulesTotalCount: scheduleCount,
                                                    lifeTime: 8)
            try schedule.run(context: .init(queueName: QueueName(string: "schedule\(idx)"),
                                            configuration: QueuesConfiguration(),
                                            application: app,
                                            logger: app.logger,
                                            on: app.eventLoopGroup.next())
            ).wait()
        }
        
        // Test to see leaderboard is populated
        let playerCount = try redis.zcard(of: playersLeaderboardKey).wait()
        XCTAssertNotEqual(playerCount, 0)
        
        // Save to redis
        try redis.set(minTrophyCountKey, to: 6700).wait()
        // Test to see if its successfully saved
        let redisMinTrophies = try redis.get(minTrophyCountKey, as: Int.self).wait()
        XCTAssertEqual(redisMinTrophies, 6700)
        
        let reseter = GlobalLeaderboardDataReseter()
        try reseter.run(context: .init(queueName: QueueName(string: "dataReseter"),
                                       configuration: QueuesConfiguration(),
                                       application: app,
                                       logger: app.logger,
                                       on: app.eventLoopGroup.next())
        ).wait()
        
        // Test to see if the values are reseted
        let newPlayerCount = try redis.zcard(of: playersLeaderboardKey).wait()
        XCTAssertEqual(newPlayerCount, 0)
        
        // Test to see if changes have successfully taken effect
        let newRedisMinTrophies = try redis.get(minTrophyCountKey, as: Int.self).wait()
        XCTAssertTrue(newRedisMinTrophies == nil || newRedisMinTrophies == 0)
    }

}
