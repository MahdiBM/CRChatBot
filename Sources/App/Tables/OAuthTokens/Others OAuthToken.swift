import Vapor

//MARK: -Issuer
extension OAuthTokens {
    enum Issuer: String, Content {
        case twitch
    }
}

//MARK: -Equatable Conformance
extension OAuthTokens: Equatable {
    public static func == (lhs: OAuthTokens, rhs: OAuthTokens) -> Bool {
        lhs.accessToken == rhs.accessToken
            && lhs.refreshToken == rhs.refreshToken
            && lhs.expiresIn == rhs.expiresIn
            && lhs.scope == rhs.scope
            && lhs.tokenType == rhs.tokenType
            && lhs.streamerId == rhs.streamerId
            && lhs.issuer == rhs.issuer
    }
}

//MARK: -Expiration
extension OAuthTokens {
    var expiryDate: Date? {
        guard let createdAt = createdAt else {
            return nil
        }
        let tokenLifeLength = expiresIn - 15 /* -15 just incase */
        let expiryDate = createdAt.addingTimeInterval(TimeInterval(tokenLifeLength))
        return expiryDate
    }
    
    var hasExpired: Bool {
        let now = Date()
        let hasExpired = try? self.expiryDate.throwingUnwrap() <= now
        return hasExpired == true
    }
}
