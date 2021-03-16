import Vapor
import Fluent

final class OAuthTokens: Content, Model {
    
    static let schema: String = "oauthToken"
    
    @ID(key: .id)
    var id: UUID?
    
    //MARK: - Normal OAuth-2 Token Fields
    @Field(key: FieldKeys.accessToken)
    var accessToken: String
    
    @Field(key: FieldKeys.refreshToken)
    var refreshToken: String
    
    @Field(key: FieldKeys.expiresIn)
    var expiresIn: Int
    
    @Field(key: FieldKeys.scope)
    var scope: [String]
    
    @Field(key: FieldKeys.tokenType)
    var tokenType: String
    
    //MARK: - Other Fields
    
    /// The id of the streamer who created this token.
    /// Its not used yet almost anywhere.
    @Field(key: FieldKeys.streamerId)
    var streamerId: UUID?
    
    /// The provider which issued this token.
    /// Currently only Twitch.
    @Field(key: FieldKeys.issuer)
    var issuer: Issuer
    
    /// The Date when this OAuthToken was created.
    @Timestamp(key: FieldKey(FieldKeys.createdAt), on: .create)
    var createdAt: Date?
    
    //MARK: -Initializers
    init() {}
    
    init(id: UUID? = nil,
         accessToken: String,
         refreshToken: String,
         expiresIn: Int,
         scope: [String],
         tokenType: String,
         streamerId: UUID? = nil,
         issuer: Issuer
    ) {
        self.id = id
        self.streamerId = streamerId
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.scope = scope
        self.tokenType = tokenType
        self.issuer = issuer
    }
}



