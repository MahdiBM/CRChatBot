@testable import App
import XCTVapor
import Fluent

final class OAuthTokensTests: XCTestCase {
    var app: Application!
    let adminAuthenticator = Authenticators.AdminAuthenticator()
    let baseUrl = "twitch/api/v1/tokens/"
    
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
        
        // make random instances
        let instance1: OAuthTokens = .random()
        let instance2: OAuthTokens = .random()
        let instance3: OAuthTokens = .random()
        let instance4: OAuthTokens = .random()
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
            XCTAssertContent(Page<OAuthTokens>.self, res) { content in
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
            let testableValue = instance1.accessToken
            try req.query.encode(KeyValue(key: OAuthTokens.FieldKeys.accessToken.rawValue,
                                          value: testableValue))
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        
        // test to make sure instance1 has been deleted
        try app.test(.GET, baseUrl + "all", headers: authHeader) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(Page<OAuthTokens>.self, res) { content in
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
            let testableValue = instance3.accessToken
            try req.query.encode(KeyValue(key: OAuthTokens.FieldKeys.accessToken.rawValue,
                                          value: testableValue))
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(Page<OAuthTokens>.self, res) { content in
                XCTAssertEqual(content.metadata.page, 1)
                XCTAssertEqual(content.metadata.per, 10)
                XCTAssertEqual(content.metadata.total, 1)
                XCTAssertEqual(content.items, [instance3])
            }
        })
        
        // test to see requesting to find only one value works well
        try app.test(.GET, baseUrl + "find", headers: authHeader, beforeRequest: { req in
            let testableValue = instance4.accessToken
            try req.query.encode(KeyValue(key: OAuthTokens.FieldKeys.accessToken.rawValue,
                                          value: testableValue))
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(OAuthTokens.self, res) { content in
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


