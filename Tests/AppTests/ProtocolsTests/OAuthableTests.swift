@testable import App
import XCTVapor
import Fluent
import FluentPostgresDriver

final class OAuthableTests: XCTestCase {
    var app: Application!
    var oauthToken: OAuthTokens!
    var oauthableValue: some OAuthable { OAuth.twitch }
    let tokenPath = "/Tests/TestabilityResources/OAuthableTestToken.txt"
    let fileManager = FileManager()
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try Configuration(app).perform()
        oauthToken = Self.getOAuthTokenFromThePersistentFile()
    }
    
    override func tearDown() {
        app.shutdown()
    }
    
    // If failed, read `## Explanation about tests which might fail without app's fault`
    // in the `TestsInfo.md` file before more investigations.
    func testOAuthable() throws {
        
        // Test if the `OAuthable.renewTokenIfExpired(req:token:)` function
        // is taking care of the token being a fresh one.
        // It will not really test anything if the token is fresh, but
        // i think it does suffice considering there are lots of other tests.
        do {
            let request = Request(application: app, on: app.eventLoopGroup.next())
            let token = try oauthableValue
                .renewTokenIfExpired(request, token: oauthToken).wait()
            // New token is supposed to be refreshed, so we call the renewTokenIfExpired
            // function again and it must return the same token.
            let newToken = try oauthableValue
                .renewTokenIfExpired(request, token: token).wait()
            
            XCTAssertEqual(token.accessToken, newToken.accessToken)
            XCTAssertEqual(token.expiresIn, newToken.expiresIn)
            XCTAssertEqual(token.createdAt, newToken.createdAt)
            XCTAssertEqual(token.id, newToken.id)
            XCTAssertEqual(token.issuer, newToken.issuer)
            XCTAssertEqual(token.refreshToken, newToken.refreshToken)
            XCTAssertEqual(token.scope, newToken.scope)
            XCTAssertEqual(token.streamerId, newToken.streamerId)
            XCTAssertEqual(token.tokenType, newToken.tokenType)
            
            oauthToken = newToken
            // Save the refreshed token to the persistent file.
            try fileManager.saveAsJSONString(newToken, relativePath: tokenPath)
        }
        
        do {
            // Due to session middleware not working well with manually-made
            // requests in tests, we have to call the endpoint which uses the
            // `OAuthable.requestAuthorization(req:)` function, instead of
            // creating a request and calling the function directly.
            try app.test(.GET, "/twitch/api/v1/oauth/register") { res in
                XCTAssertEqual(res.status, .seeOther)
            }
        }
        
        // Test the callback function through the callback endpoint.
        do {
            let fakeQueryParams = OAuth.twitch.fakeCallbackQueryParameters
            let req = Request(application: app, on: app.eventLoopGroup.next())
            let sessionData = SessionData(initialData: ["state": fakeQueryParams.state])
            let sessionId = try app.sessions.driver.createSession(sessionData, for: req).wait()
            let cookieHeader = HTTPHeaders([("Cookie", "CRChatBot=\(sessionId.string)")])
            
            try app.test(.GET, "/twitch/api/v1/oauth/callback", headers: cookieHeader, beforeRequest: {
                req in
                try req.query.encode(fakeQueryParams)
            }, afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                XCTAssertContent(OAuthTokens.self, res) { token in
                    XCTAssertNotNil(token.id)
                    XCTAssertFalse(token.accessToken.isEmpty)
                    XCTAssertFalse(token.refreshToken.isEmpty)
                    XCTAssertFalse(token.expiresIn == 0)
                    XCTAssertFalse(token.scope.isEmpty)
                    XCTAssertFalse(token.tokenType.isEmpty)
                    XCTAssertNil(token.streamerId)
                    XCTAssertTrue(token.issuer == .twitch)
                    XCTAssertNotNil(token.createdAt)
                }
            })
        }
        
        // Test getting App Access Token.
        do {
            let request = Request(application: app, on: app.eventLoopGroup.next())
            let appAccessToken = try oauthableValue.getAppAccessToken(request).wait()
            XCTAssertFalse(appAccessToken.accessToken.isEmpty)
            XCTAssertFalse(appAccessToken.expiresIn == 0)
            XCTAssertFalse(appAccessToken.tokenType.isEmpty)
        }
    }
    
    /// Tries to retrieve an oauth token from a file which should exist
    /// at `/Tests/TestabilityResources/` named `OAuthableTestToken.txt`.
    /// Throws a fatal error if it the file doesn't exist or it can't decode
    /// an `OAuthTokens` out of the file contents.
    /// Returns the retrieved token if the process is successful.
    static func getOAuthTokenFromThePersistentFile() -> OAuthTokens {
        let tokenPath = "/Tests/TestabilityResources/OAuthableTestToken.txt"
        let fileManager = FileManager()
        let decoder = JSONDecoder()
        let currentPath = fileManager.currentDirectoryPath
        let path = currentPath + tokenPath
        
        guard let data = fileManager.contents(atPath: path),
              let token = try? decoder.decode(OAuthTokens.self, from: data) else {
            // Creates the file `OAuthableTestToken.txt` in `/Tests/TestabilityResources/`
            // if it doesn't exist. Just for convenience.
            if !fileManager.fileExists(atPath: path) {
                fileManager.createFile(atPath: path, contents: nil, attributes: nil)
            }
            fatalError(
                "Please run the app and trigger the `twitch/api/v1/oauth/register`"
                    + " endpoint and copy-paste the token JSON String to the file"
                    + " in the `/Tests/TestabilityResources` directory named `OAuthableTestToken.txt`."
                    + " Don't forget to change `\"createdAt\":\"SomeDateHere\"` to"
                    + " `\"createdAt\":null`, or otherwise the tests won't be able"
                    + " to decode the token from the file."
                    + " This process is something you'll need to do only once "
                    + " in a while maybe, and is not required every time."
            )
        }
        
        return token
    }
}
