@testable import App
import XCTVapor
import NIO
import Redis
import Queues

final class UpdatePlayersLeaderboardTests: XCTestCase {
    var app: Application!
    var redis: Application.Redis!
    let playersLeaderboardKey = RedisKey(for: .playerLeaderboardItems)
    
    override func setUpWithError() throws {
        app = Application(.testing)
        redis = app.redis
        try Configuration(app).perform()
        // Redis requires `app.boot()` for some reasons.
        try app.boot()
        _ = try app.redis.delete(playersLeaderboardKey).wait()
    }
    
    override func tearDown() {
        _ = try! app.redis.delete(playersLeaderboardKey).wait()
        app.shutdown()
    }
    
    func testConnection() throws {
        let info = try app.redis.send(command: "INFO").wait()
        XCTAssertContains(info.string, "redis_version")
    }
    
    // If failed, read `## Explanation about tests which might fail without app's fault`
    // in the `TestsInfo.md` file before more investigations.
    func testSchedule() throws {
        
        let scheduleCount = 5
        for idx in 0..<scheduleCount {
            let schedule = UpdatePlayersLeaderboard(scheduleOffset: idx,
                                                    schedulesTotalCount: scheduleCount,
                                                    lifeTime: 8)
            _ = try schedule.run(context: .init(queueName: QueueName(string: "schedule\(idx)"),
                                                configuration: QueuesConfiguration(),
                                                application: app,
                                                logger: app.logger,
                                                on: app.eventLoopGroup.next())).wait()
        }
        
        let countOfPlayersSavedToDb = try redis.zcard(of: self.playersLeaderboardKey).wait()
        XCTAssertTrue(countOfPlayersSavedToDb >= 5000)
    }
    
}


