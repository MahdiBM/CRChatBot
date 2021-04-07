import Vapor

extension OAuth {
    /// Twitch model which is capable of performing OAuth tasks.
    struct Twitch: OAuthable {
        /*
         See OAuthable protocol's explanation for insight about all below stuff.
         */
        
        let clientId = <#client id#>
        let clientSecret = <#client secret#>
        // The callbackUrl to be used only in tests.
        private let testCallbackUrl = testDict["twitchTestCallbackUrl"] as? String
        private let productionCallbackUrl = <#production callback url#>
        var callbackUrl: String { testCallbackUrl ?? productionCallbackUrl }
        let providerAuthorizationUrl = "https://id.twitch.tv/oauth2/authorize"
        let providerTokenUrl = "https://id.twitch.tv/oauth2/token"
        let queryParametersPolicy: Policy = .passInUrl
        let issuer: OAuthTokens.Issuer = .twitch
        
        enum Scopes: String, CaseIterable {
            case analyticsReadExtensions = "analytics:read:extensions"
            case analyticsReadGames = "analytics:read:games"
            case bitsRead = "bits:read"
            case channelEditCommercial = "channel:edit:commercial"
            case channelManageBroadcast = "channel:manage:broadcast"
            case channelManageExtensions = "channel:manage:extensions"
            case channelManageRedemptions = "channel:manage:redemptions"
            case channelManageVideos = "channel:manage:videos"
            case channelReadEditors = "channel:read:editors"
            case channelReadHypeTrain = "channel:read:hype_train"
            case channelReadRedemptions = "channel:read:redemptions"
            case channelReadStreamKey = "channel:read:stream_key"
            case channelReadSubscriptions = "channel:read:subscriptions"
            case clipsEdit = "clips:edit"
            case moderationRead = "moderation:read"
            case userEdit = "user:edit"
            case userEditFollows = "user:edit:follows"
            case userReadBlockedUsers = "user:read:blocked_users"
            case userManageBlockedUsers = "user:manage:blocked_users"
            case userReadBroadcast = "user:read:broadcast"
            case userReadEmail = "user:read:email"
        }
    }
}
