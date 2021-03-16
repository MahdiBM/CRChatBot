import Vapor
import Fluent

final class UserRequests: Content, Model {
    
    static let schema: String = "userRequest"
    
    @ID(key: .id)
    var id: UUID?
    
    //MARK: -Fields
    
    /// Twitch username of the one who requested.
    @Field(key: FieldKeys.username)
    var username: String
    
    /// Timestamp since 1970 of when
    /// this user request was made.
    @Field(key: FieldKeys.timestamp)
    var timestamp: Int
    
    /// A little bit of info about what the user requested.
    @Field(key: FieldKeys.description)
    var description: String
    
    //MARK: - Relations
    @Parent(key: FieldKey(FieldKeys.streamerId))
    var streamer: Streamers
    
    //MARK: -Initializers
    init() {}
    
    init(id: UUID? = nil,
         streamerId: UUID,
         username: String,
         timestamp: Int,
         description: String
    ) {
        self.id = id
        self.username = username
        self.timestamp = timestamp
        self.description = description
        self.$streamer.id = streamerId
    }
    
}

