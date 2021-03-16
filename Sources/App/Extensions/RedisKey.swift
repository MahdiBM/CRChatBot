import Redis

extension RedisKey {
    init(for redisKey: Keys) {
        self = redisKey.key
    }
    
    enum Keys: String {
        /// Key for player's that are saved to redis.
        /// The key holds tens of thousands of values of type `DTOs.Redis.Player`.`
        /// Retrieve from redis only using `DTOs.Redis.Player.loadFromDb`.
        case playerLeaderboardItems
        /// Key for minimum trophy required for a player to appear
        /// in the global leaderboard.
        /// The key holds a single value of type `Int`.
        case minimumGlobalLeaderboardTrophies
        
        fileprivate var key: RedisKey {
            .init(self.rawValue)
        }
    }
}
