import Vapor
import Fluent

final class Streamers: Content, Model {
    
    static let schema: String = "streamer"
    
    @ID(key: .id)
    var id: UUID?
    
    //MARK: -Fields
    @Field(key: FieldKeys.channelName)
    var channelName: String
    
    /// Last time the app checked and saw the streamer is online.
    /// This property helps prevent too many calls to Twitch API
    /// which make the app slow.
    @Field(key: FieldKeys.lastOnline)
    var lastOnline: Int
    
    /// Whether or not the streamer is blacklisted.
    /// Defaults to false obviously.
    @Field(key: FieldKeys.isBlacklisted)
    var isBlacklisted: Bool
    
    /// Whether or not the app should check if the streamer is online
    /// before answering a request from the streamer's chat.
    /// Defaults to true.
    @Field(key: FieldKeys.performOnlineChecks)
    var performOnlineChecks: Bool
    
    /// Can contain useful info about the streamer.
    /// See `Streamers.InfoKeys`.
    @Field(key: FieldKeys.infoDictionary)
    var infoDict: [String: String]
    
    /// The Date when this Streamer was created.
    @Timestamp(key: FieldKey(FieldKeys.createdAt), on: .create)
    var createdAt: Date?
    
    //MARK: -Relations
    @Children(for: \.$streamer)
    var requests: [UserRequests]
    
    //MARK: -Initializers
    init() {}
    
    init(id: UUID? = nil,
         channelName: String
    ) {
        self.id = id
        self.channelName = channelName
        self.lastOnline = 0
        self.isBlacklisted = false
        self.performOnlineChecks = true
        self.infoDict = [:]
    }
    
}

