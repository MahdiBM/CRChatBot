import Vapor

/// Enables OAuth-2 tasks.
protocol OAuthable {
    /// Convenience typealias for the type representing
    /// the policy to encode query parameters with.
    typealias Policy = QueryParametersPolicy
    
    /// Scopes that the app can get permissions to access.
    /// An enum conforming to `String` and `CaseIterable`
    /// is the best way. (see OAuth.Twitch.Scopes)
    associatedtype Scopes: CaseIterable & RawRepresentable
    where Scopes.RawValue == String
    
    /// Your client id, acquired after registering your app in your provider's panel.
    var clientId: String { get }
    
    /// Your client secret, acquired after registering your app in your provider's panel.
    var clientSecret: String { get }
    
    /// Your callback url.
    /// Must be registered as one of the callback urls in your provider's panel.
    var callbackUrl: String { get }
    
    /// Provider's endpoint that you redirect users to;
    /// So they are asked to give permissions to this app.
    var providerAuthorizationUrl: String { get }
    
    /// After getting a `code` from the provider when a user has given permissions to this app,
    /// The `code` is passed to this url and in return, an `access token` is acquired.
    var providerTokenUrl: String { get }
    
    /// The policy to encode query parameters with.
    var queryParametersPolicy: Policy { get }
    
    /// The provider which issues these tokens.
    var issuer: OAuthTokens.Issuer { get }
}
