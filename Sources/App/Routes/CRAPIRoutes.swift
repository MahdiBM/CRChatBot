import Vapor

class CRAPIRoutes: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let baseRoute = routes.grouped("crapi")
        let adminRoute = baseRoute.grouped(Authenticators.AdminAuthenticator())
        
        requestFromCRAPI(route: adminRoute)
    }
    
    /// Requests from the official Clash Royale API.
    private func requestFromCRAPI(route: RoutesBuilder) {
        let crapiCases = CRAPIRequest.allCases
        for crCase in crapiCases {
            let pathComponents = crCase.pathComponents
            route.get(pathComponents) { req -> ELF<ClientResponse> in
                let clientRequest = CRAPIRequest.clientRequest(using: req.url.string)
                let clientResponse = req.client.send(clientRequest)
                return clientResponse
            }
        }
    }
    
}
