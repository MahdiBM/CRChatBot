@testable import App
import XCTVapor
import Fluent

final class UserRequestsTests: XCTestCase {
    var app: Application!
    let adminAuthenticator = Authenticators.AdminAuthenticator()
    let baseUrl = "twitch/api/v1/requests/"
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try Configuration(app).perform()
    }
    
    override func tearDown() {
        app.shutdown()
    }
    
    func testBaseRoutes() throws {
        var authHeader = HTTPHeaders()
        authHeader.basicAuthorization = adminAuthenticator.ultimateOwnerAdmin
        
        // make random streamer instances
        // because a UserRequest needs a valid Streamers as its parent
        let streamer1: Streamers = .random()
        let streamer2: Streamers = .random()
        let streamer3: Streamers = .random()
        let streamer4: Streamers = .random()
        let streamers = [streamer1, streamer2, streamer3, streamer4]
        
        // make sure instances are unique
        XCTAssertNotEqual(streamer1, streamer2)
        XCTAssertNotEqual(streamer2, streamer3)
        XCTAssertNotEqual(streamer3, streamer4)
        
        // save streamers into db
        for streamer in streamers {
            try streamer.save(on: app.db).wait()
        }
        
        // make random instances
        let instance1: UserRequests = .random(streamerId: try streamer1.id.throwingUnwrap())
        let instance2: UserRequests = .random(streamerId: try streamer2.id.throwingUnwrap())
        let instance3: UserRequests = .random(streamerId: try streamer3.id.throwingUnwrap())
        let instance4: UserRequests = .random(streamerId: try streamer4.id.throwingUnwrap())
        let instances = [instance1, instance2, instance3, instance4]
        
        // make sure instances are unique
        XCTAssertNotEqual(instance1, instance2)
        XCTAssertNotEqual(instance2, instance3)
        XCTAssertNotEqual(instance3, instance4)
        
        // save instances on db
        for instance in instances {
            try app.test(.POST, baseUrl + "save", headers: authHeader, beforeRequest: { req in
                try req.content.encode(instance)
            }, afterResponse: { res in
                XCTAssertEqual(res.status, .created)
            })
        }
        
        // test to make sure test instances are saved indeed
        try app.test(.GET, baseUrl + "all", headers: authHeader) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(Page<UserRequests>.self, res) { content in
                XCTAssertEqual(content.metadata.page, 1)
                XCTAssertEqual(content.metadata.per, 10)
                XCTAssertEqual(content.metadata.total, instances.count)
                XCTAssertEqual(content.items.count, instances.count)
                for instance in instances {
                    XCTAssertTrue(content.items.contains(instance))
                }
            }
        }
        
        // delete instance1
        try app.test(.DELETE, baseUrl + "delete", headers: authHeader, beforeRequest: { req in
            let testableValue = instance1.username
            try req.query.encode(KeyValue(key: UserRequests.FieldKeys.username.rawValue,
                                          value: testableValue))
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        
        // test to make sure instance1 has been deleted
        try app.test(.GET, baseUrl + "all", headers: authHeader) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(Page<UserRequests>.self, res) { content in
                XCTAssertEqual(content.metadata.page, 1)
                XCTAssertEqual(content.metadata.per, 10)
                XCTAssertEqual(content.metadata.total, 3)
                XCTAssertEqual(content.items.count, 3)
                for instance in [instance2, instance3, instance4] {
                    XCTAssertTrue(content.items.contains(instance))
                }
            }
        }
        
        // test to see if filtering works as intended
        try app.test(.GET, baseUrl + "filter", headers: authHeader, beforeRequest: { req in
            let testableValue = instance3.username
            try req.query.encode(KeyValue(key: UserRequests.FieldKeys.username.rawValue,
                                          value: testableValue))
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(Page<UserRequests>.self, res) { content in
                XCTAssertEqual(content.metadata.page, 1)
                XCTAssertEqual(content.metadata.per, 10)
                XCTAssertEqual(content.metadata.total, 1)
                XCTAssertEqual(content.items, [instance3])
            }
        })
        
        // test to see requesting to find only one value works well
        try app.test(.GET, baseUrl + "find", headers: authHeader, beforeRequest: { req in
            let testableValue = instance4.username
            try req.query.encode(KeyValue(key: UserRequests.FieldKeys.username.rawValue,
                                          value: testableValue))
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(UserRequests.self, res) { content in
                XCTAssertEqual(content, instance4)
            }
        })
        
        // test to see count endpoint works well
        try app.test(.GET, baseUrl + "count", headers: authHeader) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "3")
        }
    }
}

