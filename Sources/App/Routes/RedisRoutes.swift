import Vapor
import Fluent
import Redis

class RedisRoutes: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let baseRoute = routes.grouped("redis")
        let adminRoute = baseRoute.grouped(Authenticators.AdminAuthenticator())
        
        adminRoute.get("count", use: getPlayersCount)
        adminRoute.get("minTrophies", use: getMinimumTrophies)
        adminRoute.get("purge", use: purgePlayersLeaderboard)
        adminRoute.get("players", ":score", use: getPlayersWithScore)
    }
    
    private func getMinimumTrophies(_ req: Request) -> ELF<String> {
        let redisKey = RedisKey(for: .minimumGlobalLeaderboardTrophies)
        return req.redis.get(redisKey).map { $0.description }
    }
    
    private func purgePlayersLeaderboard(_ req: Request) -> ELF<Int> {
        let redisKey = RedisKey(for: .playerLeaderboardItems)
        return req.redis.delete(redisKey)
    }
    
    private func getPlayersWithScore(_ req: Request) throws -> ELF<[DTOs.Redis.Player]> {
        let score = try req.parameters.require("score", as: Int.self)
        let reducer = (try? req.query.get(Double.self, at: "reducer")) ?? 1
        return DTOs.Redis.Player.loadFromDb(req, for: score, intervalReducer: reducer)
    }
    
    private func getPlayersCount(_ req: Request) -> ELF<Int> {
        let redisKey = RedisKey(for: .playerLeaderboardItems)
        return req.redis.zcard(of: redisKey)
    }
}
