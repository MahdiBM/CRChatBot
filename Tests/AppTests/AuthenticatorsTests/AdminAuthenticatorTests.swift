@testable import App
import XCTVapor

final class AdminAuthenticatorTests: XCTestCase {
    var app: Application!
    let adminAuthenticator = Authenticators.AdminAuthenticator()
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try Configuration(app).perform()
    }
    
    override func tearDown() {
        app.shutdown()
    }
    
    func testAdminAuthenticator() throws {
        // Making sure authentication works when there is an admin.
        do {
            let adminCredentials = adminAuthenticator.ultimateOwnerAdmin
            var headers = HTTPHeaders()
            headers.basicAuthorization = adminCredentials
            let request = Request.init(application: app, headers: headers, on: app.eventLoopGroup.next())
            let adminAuthentication = adminAuthenticator.respond(to: request, chainingTo: FakeResponder())
            XCTAssertNoThrow(try adminAuthentication.wait())
        }
        
        // Making sure `Abort.unauthorized` is thrown when there are no admins.
        do {
            let randomCredentials = BasicAuthorization.init(
                username: .random(length: 16),
                password: .random(length: 16)
            )
            var headers = HTTPHeaders()
            headers.basicAuthorization = randomCredentials
            let request = Request.init(application: app, headers: headers, on: app.eventLoopGroup.next())
            let adminAuthentication = adminAuthenticator.respond(to: request, chainingTo: FakeResponder())
            XCTAssertThrowsError(try adminAuthentication.wait()) { error in
                let abortError = error as? Abort
                XCTAssertEqual(abortError?.status, Abort(.unauthorized).status)
            }
        }
    }
}

private struct FakeResponder: Responder {
    func respond(to req: Request) -> EventLoopFuture<Response> {
        req.eventLoop.future(
            Response.init(
                status: .ok,
                version: .http1_1,
                headersNoUpdate: .init(),
                body: .init()))
    }
}
