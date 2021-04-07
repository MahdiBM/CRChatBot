import Vapor

//MARK: - Private Declarations

private extension OAuthable {
    /// Joins the scopes together and makes them passable in a request.
    func join(scopes: [Scopes]) -> String {
        scopes.map(\.rawValue).joined(separator: " ")
    }
    
    /// The url to redirect user to,
    /// so they are asked to give this app permissions to access their data.
    /// - Throws: OAuthableError in case of error.
    func authorizationRedirectUrl(state: String? = nil,
                                  scopes: [Scopes] = Array(Scopes.allCases))
    -> String {
        let queryParams = QueryParameters.init(client_id: self.clientId,
                                               response_type: "code",
                                               redirect_uri: self.callbackUrl,
                                               scope: join(scopes: scopes),
                                               state: state)
        let redirectUrl = self.providerAuthorizationUrl + "?" + queryParams.queryString
        return redirectUrl
    }
    
    /// The request that gets an access token from the provider,
    /// using the `code` that this app should acquired after
    /// user being redirected to this app by the provider.
    /// - Throws: OAuthableError in case of error.
    func getUserAccessTokenRequest(code: String)
    throws -> ClientRequest {
        let queryParams = QueryParameters.init(client_id: self.clientId,
                                               client_secret: self.clientSecret,
                                               redirect_uri: self.callbackUrl,
                                               grant_type: "authorization_code",
                                               code: code)
        var clientRequest = ClientRequest()
        clientRequest.method = .POST
        clientRequest.url = .init(string: self.providerTokenUrl)
        
        let queryParametersEncode: Void? = try? self.queryParametersPolicy
            .inject(parameters: queryParams, into: &clientRequest)
        guard queryParametersEncode != nil else {
            throw OAuthableError.internalFailure(
                reason: .queryParametersEncodeError(policy: queryParametersPolicy)
            )
        }
        
        return clientRequest
    }
    
    /// The request to refresh an expired token with.
    /// - Throws: OAuthableError in case of error.
    func refreshTokenRequest(refreshToken: String)
    throws -> ClientRequest {
        let queryParams = QueryParameters.init(client_id: self.clientId,
                                               client_secret: self.clientSecret,
                                               grant_type: "refresh_token",
                                               refresh_token: refreshToken)
        var clientRequest = ClientRequest()
        clientRequest.method = .POST
        clientRequest.url = .init(string: self.providerTokenUrl)
        
        let queryParametersEncode: Void? = try? self.queryParametersPolicy
            .inject(parameters: queryParams, into: &clientRequest)
        guard queryParametersEncode != nil else {
            throw OAuthableError.internalFailure(
                reason: .queryParametersEncodeError(policy: queryParametersPolicy)
            )
        }
        
        return clientRequest
    }
    
    /// The request to acquire an app access token.
    /// - Throws: OAuthableError in case of error.
    func getAppAccessTokenRequest()
    throws -> ClientRequest {
        let queryParams = QueryParameters.init(client_id: self.clientId,
                                               client_secret: self.clientSecret,
                                               grant_type: "client_credentials")
        var clientRequest = ClientRequest()
        clientRequest.method = .POST
        clientRequest.url = .init(string: self.providerTokenUrl)
        
        let queryParametersEncode: Void? = try? self.queryParametersPolicy
            .inject(parameters: queryParams, into: &clientRequest)
        guard queryParametersEncode != nil else {
            throw OAuthableError.internalFailure(
                reason: .queryParametersEncodeError(policy: queryParametersPolicy)
            )
        }
        
        return clientRequest
    }
    
    /// Searches for other tokens for this user and Returns a token that has not expired yet.
    /// tries to renew a token if there is only one token left.
    /// - Returns: A fresh token.
    func renewToken(_ req: Request, token currentToken: OAuthTokens) -> ELF<OAuthTokens> {
        let anotherToken: EventLoopFuture<OAuthTokens?>
        if let streamerId = currentToken.streamerId {
            anotherToken = OAuthTokens.query(on: req.db)
                .filter(\.$streamerId, .equal, streamerId)
                .filter(\.$accessToken, .notEqual, currentToken.accessToken)
                .all()
                .map { $0.randomElement() }
        } else {
            anotherToken = req.eventLoop.future(nil)
        }
        
        let deleteCurrentToken = anotherToken.flatMap { anotherToken -> ELF<OAuthTokens?> in
            if let anotherToken = anotherToken {
                return currentToken.delete(on: req.db).map { _ in anotherToken }
            } else {
                return req.eventLoop.future(nil)
            }
        }
        let renewedToken = deleteCurrentToken.tryFlatMap { newToken -> ELF<OAuthTokens> in
            if let newToken = newToken {
                return renewTokenIfExpired(req, token: newToken)
            } else {
                return try forceRefreshToken(req, token: currentToken)
            }
        }
        
        return renewedToken
    }
    
    /// Immediately tries to refresh a token.
    /// - Throws: OAuthableError in case of error.
    /// - Returns: A fresh token.
    func forceRefreshToken(_ req: Request, token: OAuthTokens) throws -> ELF<OAuthTokens> {
        let clientRequest = try self.refreshTokenRequest(refreshToken: token.refreshToken)
        let clientResponse = req.client.send(clientRequest)
        let refreshTokenContent = clientResponse.flatMapThrowing {
            res -> DTOs.OAuth.UserRefreshToken in
            try decode(response: res, request: req, as: DTOs.OAuth.UserRefreshToken.self)
        }
        let newToken = refreshTokenContent.map { refreshToken in
            refreshToken.makeNewOAuthToken(oldToken: token)
        }
        let saveNewTokenOnDb = newToken.flatMap { newToken -> ELF<OAuthTokens>  in
            newToken.save(on: req.db).map { _ in newToken }
        }
        let deleteOldToken = saveNewTokenOnDb.flatMap { newToken in
            token.delete(on: req.db).map { _ in newToken }
        }
        
        return deleteOldToken.map { $0 }
    }
    
    /// Decodes response's content while taking care of errors.
    ///   - type: Type to decode the content to.
    /// - Throws: OAuthableError in case of error.
    /// - Returns: The decoded content.
    func decode<T>(response res: ClientResponse, request req: Request, as type: T.Type)
    throws -> T where T: Content {
        if res.status == .ok,
           let content = try? res.content.decode(T.self) {
            return content
        } else {
            if let error = try? req.query.get(String.self, at: "error") {
                throw OAuthableError.providerError(status: res.status, error: error)
            } else {
                throw OAuthableError.providerError(status: res.status, error: res.body?.contentString)
            }
        }
    }
}

//MARK: - Public Funcs

extension OAuthable {
    /// Tries to acquire an app access token.
    /// - Throws: OAuthableError in case of error.
    func getAppAccessToken(_ req: Request) throws -> ELF<DTOs.OAuth.AppAccessToken> {
        let clientRequest = try self.getAppAccessTokenRequest()
        let clientResponse = req.client.send(clientRequest)
        let tokenContent = clientResponse.flatMapThrowing { res in
            try decode(response: res, request: req, as: DTOs.OAuth.AppAccessToken.self)
        }
        
        return tokenContent
    }
    
    /// Redirects user to the provider page where they're asked to give this app permissions.
    func requestAuthorization(_ req: Request) throws -> Response {
        let state = String.random(length: 64)
        let authUrl = self.authorizationRedirectUrl(state: state)
        req.session.data["state"] = state
        return req.redirect(to: authUrl)
    }
    
    /// Takes care of callback endpoint's actions,
    /// after the user hits the authorization endpoint
    /// and gets redirected back to this app by the provider.
    /// - Throws: OAuthableError in case of error.
    func authorizationCallback(_ req: Request)
    throws -> ELF<OAuthTokens> {
        typealias QueryParams = DTOs.OAuth.AuthorizationQueryParameters
        guard let params = try? req.query.decode(QueryParams.self) else {
            if let error = try? req.query.get(String.self, at: "error") {
                throw OAuthableError.providerError(status: .badRequest, error: error)
            } else {
                throw OAuthableError.providerError(status: .badRequest, error: req.body.string)
            }
        }
         
        let state = req.session.data["state"]
        req.session.destroy()
        let isStateValid = params.state == state
        guard isStateValid else {
            throw OAuthableError.invalidCookie
        }
        
        let clientRequest = try self.getUserAccessTokenRequest(code: params.code)
        var clientResponse = req.client.send(clientRequest)
        // Replacing the client response with a fake one for when
        // we are testing the app. As of right now, it is quite hard
        // to make it get a true response, right from the real provider.
        let isTesting = req.application.environment == .testing
        if isTesting {
            let fakeResponse = OAuth.twitch.fakeAccessTokenClientResponse
            clientResponse = clientResponse.transform(to: fakeResponse)
        }
        let accessTokenContent = clientResponse.flatMapThrowing {
            res -> DTOs.OAuth.UserAccessToken in
            try decode(response: res, request: req, as: DTOs.OAuth.UserAccessToken.self)
        }
        let saveTokenOnDb = accessTokenContent.flatMap { accessToken -> ELF<OAuthTokens> in
            let token = accessToken.convertToOAuthToken(issuer: self.issuer)
            return token.save(on: req.db).map { _ in token }
        }
        
        return saveTokenOnDb.map { $0 }
    }
    
    /// Checks if the current token is expired,
    /// tries to acquire a fresh token in case of expiration,
    /// returns the same token if it has not expired.
    func renewTokenIfExpired(_ req: Request, token: OAuthTokens) -> ELF<OAuthTokens> {
        if token.hasExpired {
            return renewToken(req, token: token)
        } else {
            return req.eventLoop.future(token)
        }
    }
}

//MARK: - QueryParameters

/// Helps encode query parameters into a request.
private struct QueryParameters: Content {
    var client_id: String? = nil
    var client_secret: String? = nil
    var response_type: String? = nil
    var redirect_uri: String? = nil
    var scope: String? = nil
    var state: String? = nil
    var grant_type: String? = nil
    var refresh_token: String? = nil
    var code: String? = nil
    
    /// The pairs of key-values that can be passed into the url.
    /// example: ["key1=value1", "key2=value2"]
    private var queryStrings: [String] {
        var allValues = [String?]()
        func append(value: String?, key: String) {
            let keyValue = (value == nil) ? nil : "\(key)=\(value!)"
            allValues.append(keyValue)
        }
        
        append(value: self.client_id, key: "client_id")
        append(value: self.client_secret, key: "client_secret")
        append(value: self.response_type, key: "response_type")
        append(value: self.redirect_uri, key: "redirect_uri")
        append(value: self.scope, key: "scope")
        append(value: self.state, key: "state")
        append(value: self.grant_type, key: "grant_type")
        append(value: self.refresh_token, key: "refresh_token")
        append(value: self.code, key: "code")
        
        return allValues.compactMap { $0 }
    }
    
    /// The string to be passed at the end of a url.
    /// example: "key1=value1&key2=value2&key3=value3"
    var queryString: String {
        self.queryStrings.joined(separator: "&")
    }
}

//MARK: - QueryParametersPolicy

/// Different ways of encoding query parameters into a request.
enum QueryParametersPolicy: String {
    /*
     Some providers like `Spotify` don't work with `.passInUrl`,
     But most providers should work well with `.passInUrl`.
     If your provider says some necessary headers/query-params
     are missing, then you can try `.useUrlEncodedForm`.
     */
    
    /// Adds the query parameters to the end of the url.
    case passInUrl
    /// Adds the query parameters to the `x-www-form-urlencoded` header.
    case useUrlEncodedForm
    
    /// The value to use if you are unsure.
    static let `default` = Self.passInUrl
    
    /// Injects parameters into a client request.
    fileprivate func inject(parameters: QueryParameters,
                            into clientRequest: inout ClientRequest) throws {
        switch self {
        case .passInUrl:
            try clientRequest.query.encode(parameters)
        case .useUrlEncodedForm:
            try clientRequest.content.encode(parameters, as: .urlEncodedForm)
        }
    }
}

//MARK: - Fake Stuff, ONLY For Tests Purposes

extension OAuthable {
    var fakeAccessTokenClientResponse: ClientResponse {
        let fakeToken = DTOs.OAuth.UserAccessToken.init(
            accessToken: .random(length: 60),
            tokenType: "bearer",
            scope: nil,
            scopes: Self.Scopes.allCases.map(\.rawValue),
            expiresIn: .random(in: 2500...36000),
            refreshToken: .random(length: 100)
        )
        
        var clientResponse = ClientResponse(status: .ok)
        try! clientResponse.content.encode(fakeToken)
        
        return clientResponse
    }
    
    var fakeCallbackQueryParameters: DTOs.OAuth.AuthorizationQueryParameters {
        .init(code: .random(length: 140),
              state: .random(length: 64))
    }
}
