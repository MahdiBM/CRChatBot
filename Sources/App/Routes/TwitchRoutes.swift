import Vapor

class TwitchRoutes: RouteCollection {
    
    static let twitch = OAuth.twitch
    
    func boot(routes: RoutesBuilder) throws {
        let baseRoute = routes
        let adminRoute = baseRoute.grouped(Authenticators.AdminAuthenticator())
        let twitch = OAuth.twitch
        
        baseRoute.get("cr", use: respondToNightBot)
        baseRoute.get("oauth", "register", use: twitch.requestAuthorization)
        baseRoute.get("oauth", "callback", use: twitch.authorizationCallback)
        adminRoute.get("search", use: searchTwitch)
    }
    
    private func respondToNightBot(_ req: Request) -> ELF<String> {
        do {
            let responder = try TwitchResponder(req: req)
            return responder.respond()
        } catch let error as TwitchResponder.ResponseError {
            return req.eventLoop.makeSucceededFuture(error.description)
        } catch {
            let error = TwitchResponder.ResponseError.unknownFailure(errorId: 438943)
            return req.eventLoop.makeSucceededFuture(error.description)
        }
    }
    
    private func searchTwitch(_ req: Request) throws -> ELF<DTOs.Twitch.SearchResults> {
        struct Param: Content {
            var query: String
        }
        let param = try req.query.get(Param.self)
        return Self.search(req, using: param.query)
            .unwrap(or: Failure.failed)
    }
}

extension TwitchRoutes {
    static func getATwitchAccessToken(_ req: Request) -> ELF<OAuthTokens?> {
        OAuthTokens.query(on: req.db)
            .filter(\.$issuer, .equal, .twitch)
            .first()
            .flatMap { token in
                if let token = token {
                    return twitch.renewTokenIfExpired(req, token: token).map { $0 }
                } else {
                    return req.eventLoop.makeSucceededFuture(nil)
                }
            }
    }
    
    static func search(_ req: Request, using queryString: String)
    -> EventLoopFuture<DTOs.Twitch.SearchResults?> {
        
        let requestFromTwitch = getATwitchAccessToken(req)
            .unwrap(or: Failure.noOAuthTokensFound)
            .flatMap { token -> EventLoopFuture<ClientResponse> in
                let uriString = "https://api.twitch.tv/helix/search/channels?query=\(queryString)"
                let uri = URI(string: uriString)
                let headers = headersForTwitchRequest(using: token)
                
                return req.client.get(uri, headers: headers)
            }
        
        let content = requestFromTwitch.map { res in
            return try? res.content.decode(DTOs.Twitch.SearchResults.self)
        }
        
        return content
    }
    
    static func isChannelLive(_ req: Request, name: String) -> EventLoopFuture<Bool?> {
        TwitchRoutes.search(req, using: name)
            .map { results in
                if let channels = results?.data {
                    let filteredChannels = channels.filter { channel in
                        channel.displayName.lowercased() == name.lowercased()
                    }
                    let isLive = filteredChannels.contains { $0.isLive == true }
                    
                    return isLive
                } else {
                    return nil
                }
            }
    }
    
    private static func headersForTwitchRequest(using token: OAuthTokens) -> HTTPHeaders {
        let clientId = OAuth.twitch.clientId
        let accessToken = token.accessToken
        let auth = "Bearer " + accessToken
        let headers = HTTPHeaders([
            ("client-id", clientId),
            ("Authorization", auth)
        ])
        return headers
    }
}


