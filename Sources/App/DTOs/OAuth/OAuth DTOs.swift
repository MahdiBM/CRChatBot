import Vapor

extension DTOs {
    /// DTOs that are used to perform OAuth-2 tasks.
    struct OAuth { }
}

extension DTOs.OAuth {
    /// Parameters that are passed to callback request by the provider,
    /// after a successful authorization.
    struct AuthorizationQueryParameters: Content {
        var code: String
        var state: String
    }
}

extension DTOs.OAuth {
    /// Access token container.
    struct UserAccessToken {
        var accessToken: String
        var tokenType: String
        var scope: String?
        var scopes: [String]?
        var expiresIn: Int
        var refreshToken: String
    }
}

extension DTOs.OAuth.UserAccessToken: Content {
    enum CodingKeys: CodingKey {
        case accessToken
        case tokenType
        case scope
        case scopes
        case expiresIn
        case refreshToken
        
        var stringValue: String {
            switch self {
            case .accessToken: return "access_token"
            case .tokenType: return "token_type"
            case .scope: return "scope"
            case .scopes: return "scope"
            case .expiresIn: return "expires_in"
            case .refreshToken: return "refresh_token"
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.tokenType = try container.decode(String.self, forKey: .tokenType)
        self.scope = try? container.decode(String.self, forKey: .scope)
        self.scopes = try? container.decode([String].self, forKey: .scopes)
        self.expiresIn = try container.decode(Int.self, forKey: .expiresIn)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}

extension DTOs.OAuth {
    /// Refresh token container.
    struct UserRefreshToken {
        var accessToken: String
        var tokenType: String
        var scope: String?
        var scopes: [String]?
        var expiresIn: Int
    }
}

extension DTOs.OAuth.UserRefreshToken: Content {
    enum CodingKeys: CodingKey {
        case accessToken
        case tokenType
        case scope
        case scopes
        case expiresIn
        
        var stringValue: String {
            switch self {
            case .accessToken: return "access_token"
            case .tokenType: return "token_type"
            case .scope: return "scope"
            case .scopes: return "scope"
            case .expiresIn: return "expires_in"
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.tokenType = try container.decode(String.self, forKey: .tokenType)
        self.scope = try? container.decode(String.self, forKey: .scope)
        self.scopes = try? container.decode([String].self, forKey: .scopes)
        self.expiresIn = try container.decode(Int.self, forKey: .expiresIn)
    }
}

extension DTOs.OAuth {
    /// App access-token container.
    struct AppAccessToken: Content {
        var accessToken: String
        var expiresIn: Int
        var tokenType: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case expiresIn = "expires_in"
            case tokenType = "token_type"
        }
    }
}

extension DTOs.OAuth.UserAccessToken {
    /// Converts `self` to an `OAuthTokens`.
    func convertToOAuthToken(issuer: OAuthTokens.Issuer) -> OAuthTokens {
        let scopesFromScope = self.scope?.components(separatedBy: " ")
        let scope = self.scopes ?? scopesFromScope ?? []
        return .init(accessToken: self.accessToken,
                     refreshToken: self.refreshToken,
                     expiresIn: self.expiresIn,
                     scope: scope,
                     tokenType: self.tokenType,
                     issuer: issuer)
    }
}

extension DTOs.OAuth.UserRefreshToken {
    /// Makes a new token with refreshed info.
    /// - Parameter oldToken: The expired token.
    func makeNewOAuthToken(oldToken: OAuthTokens) -> OAuthTokens {
        let scopesFromScope = self.scope?.components(separatedBy: " ")
        let scope = self.scopes ?? scopesFromScope ?? []
        return .init(id: .generateRandom(),
                     accessToken: self.accessToken,
                     refreshToken: oldToken.refreshToken,
                     expiresIn: self.expiresIn,
                     scope: scope,
                     tokenType: self.tokenType,
                     issuer: oldToken.issuer)
    }
}
