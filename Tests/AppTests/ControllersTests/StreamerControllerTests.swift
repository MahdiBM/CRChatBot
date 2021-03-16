@testable import App
import XCTVapor
import Fluent

final class StreamerControllerTests: XCTestCase {
    var app: Application!
    let adminAuthenticator = Authenticators.AdminAuthenticator()
    let baseUrl = "twitch/api/v1/streamers/"
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try Configuration(app).perform()
    }
    
    override func tearDown() {
        app.shutdown()
    }
    
    func testRoutes() throws {
        
        var adminHeader = HTTPHeaders()
        adminHeader.basicAuthorization = adminAuthenticator.ultimateOwnerAdmin
        
        // Test adding a new streamer
        try app.test(.GET, baseUrl + "night/add", headers: adminHeader) { res in
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, [:])
                XCTAssertEqual(streamer.isBlacklisted, false)
                XCTAssertEqual(streamer.performOnlineChecks, true)
                XCTAssertEqual(streamer.lastOnline, 0)
                XCTAssertNotNil(streamer.createdAt)
            }
        }
        
        // Test getting error if there is a redundant streamer
        try app.test(.GET, baseUrl + "night/add", headers: adminHeader) { res in
            XCTAssertEqual(res.status, .badRequest)
        }
        
        // Test getting a streamer
        try app.test(.GET, baseUrl + "night", headers: adminHeader) { res in
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, [:])
                XCTAssertEqual(streamer.isBlacklisted, false)
                XCTAssertEqual(streamer.performOnlineChecks, true)
                XCTAssertEqual(streamer.lastOnline, 0)
                XCTAssertNotNil(streamer.createdAt)
            }
        }
        
        // Test toggle blacklist
        try app.test(.GET, baseUrl + "night/toggleBlacklist", headers: adminHeader) { res in
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, [:])
                XCTAssertEqual(streamer.isBlacklisted, true)
                XCTAssertEqual(streamer.performOnlineChecks, true)
                XCTAssertEqual(streamer.lastOnline, 0)
                XCTAssertNotNil(streamer.createdAt)
            }
        }
        
        // Test toggle online checks
        try app.test(.GET, baseUrl + "night/toggleOnlineChecks", headers: adminHeader) { res in
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, [:])
                XCTAssertEqual(streamer.isBlacklisted, true)
                XCTAssertEqual(streamer.performOnlineChecks, false)
                XCTAssertEqual(streamer.lastOnline, 0)
                XCTAssertNotNil(streamer.createdAt)
            }
        }
        
        // Test adding new info to info dict
        try app.test(.GET, baseUrl + "night/setInfo?key=some&value=thing", headers: adminHeader) { res in
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, ["some": "thing"])
                XCTAssertEqual(streamer.isBlacklisted, true)
                XCTAssertEqual(streamer.performOnlineChecks, false)
                XCTAssertEqual(streamer.lastOnline, 0)
                XCTAssertNotNil(streamer.createdAt)
            }
        }
        
        // Test updating info of info dict
        try app.test(.GET, baseUrl + "night/setInfo?key=some&value=another", headers: adminHeader) { res in
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, ["some": "another"])
                XCTAssertEqual(streamer.isBlacklisted, true)
                XCTAssertEqual(streamer.performOnlineChecks, false)
                XCTAssertEqual(streamer.lastOnline, 0)
                XCTAssertNotNil(streamer.createdAt)
            }
        }
        
        // Test deleting info from info dict
        try app.test(.GET, baseUrl + "night/deleteInfo?key=some&value=doesntmatter", headers: adminHeader) { res in
            XCTAssertContent(Streamers.self, res) { streamer in
                XCTAssertEqual(streamer.channelName, "night")
                XCTAssertEqual(streamer.infoDict, [:])
                XCTAssertEqual(streamer.isBlacklisted, true)
                XCTAssertEqual(streamer.performOnlineChecks, false)
                XCTAssertEqual(streamer.lastOnline, 0)
                XCTAssertNotNil(streamer.createdAt)
            }
        }
        
        // Test for admin protection
        try app.test(.GET, baseUrl + "night") { res in
            XCTAssertEqual(res.status, .unauthorized)
        }
        
        // Test user requests
        try app.test(.GET, baseUrl + "night/requests", headers: adminHeader) { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertContent(Page<UserRequests.Public>.self, res) { requests in
                // Nothing is yet added to user requests
                XCTAssertEqual(requests.items.count, 0)
                XCTAssertEqual(requests.metadata.per, 10)
                XCTAssertEqual(requests.metadata.page, 1)
                XCTAssertEqual(requests.metadata.total, 0)
            }
        }
        
    }
}
