import Vapor

extension DTOs.Twitch {
    /// Result of a search in Twitch.
    struct SearchResults: Content {
        var data: [Result]
        
        struct Result: Content {
            var broadcasterLanguage: String
            var displayName: String
            var gameId: String
            var id: String
            var isLive: Bool
            var tagIds: [String]
            var thumbnailUrl: String
            var title: String
            var startedAt: String
            
            enum CodingKeys: String, CodingKey {
                case broadcasterLanguage = "broadcaster_language"
                case displayName = "display_name"
                case gameId = "game_id"
                case id = "id"
                case isLive = "is_live"
                case tagIds = "tag_ids"
                case thumbnailUrl = "thumbnail_url"
                case title = "title"
                case startedAt = "started_at"
            }
        }
    }
}
