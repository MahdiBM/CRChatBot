import Vapor
import Redis
import Queues

/// A job to remove and reset values of the two redis keys
/// which contain out-dateable info, every week.
struct GlobalLeaderboardDataReseter: ScheduledJob {
    func run(context: QueueContext) -> EventLoopFuture<Void> {
        let redis = context.application.redis
        let minTrophiesRedisKey = RedisKey(for: .minimumGlobalLeaderboardTrophies)
        let leaderboardPlayersRedisKey = RedisKey(for: .playerLeaderboardItems)
        let deleteKeys = redis.delete([leaderboardPlayersRedisKey, minTrophiesRedisKey])
        return deleteKeys.transform(to: ())
    }
}
