import Vapor

extension Authenticators {
    /// A type that authenticates Admin.
    /// Will block and throw HTTPStatus.unauthorized if there are no admins.
    struct AdminAuthenticator: Middleware {
        func respond(to req: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
            let isUltimateOwnerAdmin = ultimateOwnerAdmin == req.headers.basicAuthorization
            if isUltimateOwnerAdmin {
                return next.respond(to: req)
            }
            
            return req.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }
        
        let ultimateOwnerAdmin = BasicAuthorization
            .init(username: <#username#>, password: <#password#>)
    }
}
