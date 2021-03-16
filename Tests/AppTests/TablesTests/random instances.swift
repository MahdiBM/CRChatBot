@testable import App
import XCTVapor

extension OAuthTokens {
    static func random() -> Self {
        Self.init(
            accessToken: .random(length: 300),
            refreshToken: .random(length: 200),
            expiresIn: .random(in: 3000...20000),
            scope: OAuth.Twitch.Scopes.allCases.map(\.rawValue),
            tokenType: "bearer",
            issuer: .twitch
        )
    }
}

extension Streamers {
    static func random() -> Self {
        Self.init(
            channelName: .random(length: 16, using: [.uppercaseLetters, .lowercaseLetters])
        )
    }
}

extension UserRequests {
    static func random(streamerId: UUID) -> Self {
        Self.init(
            streamerId: streamerId,
            username: .random(length: 20, using: [.uppercaseLetters, .lowercaseLetters]),
            timestamp: Int(Date().timeIntervalSince1970) + .random(in: -10000...10000),
            description: .random(length: 8)
        )
    }
}
