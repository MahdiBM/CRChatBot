import Vapor
import Redis
import Fluent
import FluentPostgresDriver
import Queues
import QueuesRedisDriver

/// A dictionary to pass test/development specific stuff to
/// anywhere in the app which needs them.
public var testDict: [String: Any] = [:]

public struct Configuration {
    let app: Application
    
    public init(_ app: Application) {
        self.app = app
    }
    
    // Perform the required configurations.
    public func perform() throws {
        // Order IS important.
        databases()
        migrations()
        try testAndDevelopmentPreparation()
        sessions()
        try redis()
        try queues()
        try routes()
    }
}

private extension Configuration {
    // Configures Databases.
    func databases() {
        // This will configure 2 different databases to be used
        // depending on whether or not we are in testing environment.
        // By below configuration, test database will always run
        // on port 5443, while the main database of the app will run
        // on port 5442. Also databases `username` & `password` & `database`
        // will have an extension of `_test` at the end of them when we are in
        // testing environment.
        let isTesting = app.environment == .testing
        let testExt = isTesting ? "_test" : ""
        let basePort = isTesting ? 5433 : PostgresConfiguration.ianaPortNumber /*5432*/
        let twitchPort = basePort + 10
        
        let twitchDb = DatabaseConfigurationFactory.postgres(
            hostname: "localhost",
            port: twitchPort,
            username: <#username#> + testExt,
            password: <#password#> + testExt,
            database: <#database#> + testExt
        )
        
        app.databases.use(twitchDb, as: .psql)
    }
    
    /// Configures Migrations.
    func migrations() {
        // Order IS important. A Parent must always be
        // migrated before its Children.
        app.migrations.add(Streamers.Migration())
        app.migrations.add(UserRequests.Migration())
        app.migrations.add(OAuthTokens.Migration())
    }
    
    /// Configures Sessions.
    func sessions() {
        app.sessions.use(.redis)
        app.migrations.add(SessionRecord.migration)
        app.sessions.configuration.cookieName = "CRChatBot"
        app.middleware.use(app.sessions.middleware)
        app.sessions.configuration.cookieFactory = { sessionId in
            .init(string: sessionId.string,
                  expires: Date().addingTimeInterval(.init(300)),
                  isSecure: true,
                  isHTTPOnly: true,
                  sameSite: .strict)
        }
    }
    
    /// Configures Redis database.
    func redis() throws {
        let pool = RedisConfiguration.PoolOptions(
            maximumConnectionCount: .maximumActiveConnections(25),
            connectionRetryTimeout: .milliseconds(500)
        )
        let redisConfig = try RedisConfiguration(hostname: "localhost", pool: pool)
        app.redis.configuration = redisConfig
    }
    
    /// Configures Queues.
    func queues() throws {
        
        // Configures Queues to use redis for things like Scheduled tasks.
        app.queues.use(.redis(app.redis.configuration!))
        
        // Queues/Scheduled Jobs have their own tests,
        // and running them while testing is pointless.
        if app.environment != .testing {
            // Configures 2 `UpdatePlayersLeaderboard` to run
            // at parallel, so the process is faster.
            // For more info read `UpdatePlayersLeaderboard`'s comments.
            let count = 2
            // Start date delayed by 10s, just incase. Nothing scientific!
            let date = Date().addingTimeInterval(10)
            for idx in 0..<count {
                let task = UpdatePlayersLeaderboard(scheduleOffset: idx,
                                                    schedulesTotalCount: count)
                app.queues.schedule(task).at(date)
            }
            
            // Configures `GlobalLeaderboardDataReseter` to run
            // every Monday at 9:15 AM UTC.
            // For more info read `GlobalLeaderboardDataReseter`'s comments.
            let refresher = GlobalLeaderboardDataReseter()
            app.queues.schedule(refresher).weekly().on(.monday).at(9, 15)
            
            try app.queues.startScheduledJobs()
        }
    }
    
    // Configures Routes.
    func routes() throws {
        // You Might wonder why "twitch/api/v1", and why not
        // "api/v1/twitch" or "api/v1" ?!
        // Well, that was my personal need!
        // If you don't specifically need "twitch" to be at the
        // beginning, then you should probably just use "api/v1"
        try app.group("twitch", "api", "v1") { api in
            try api.register(collection: TwitchRoutes())
            try api.register(collection: StreamerRoutes())
            try api.register(collection: RedisRoutes())
            try api.register(collection: CRAPIRoutes())
            
            // Register some basic routes for each Model,
            // using the `registerBaseRoutes` function.
            let builder = api.grouped(Authenticators.AdminAuthenticator())
            Streamers.registerBaseRoutes(routesBuilder: builder.grouped("streamers"))
            UserRequests.registerBaseRoutes(routesBuilder: builder.grouped("requests"))
            OAuthTokens.registerBaseRoutes(routesBuilder: builder.grouped("tokens"))
        }
    }
    
}

//MARK: - Test and Development Preparation

extension Configuration {
    // This below values might need a manual change for tests not to fail.
    // Test failures that are due to these values, must not be taken
    // as something being wrong with the app.
    
    /// Clash Royale API Token, which must have been set to accept your IP.
    /// For more info read `CRAPIRequest.crapiToken`'s explanation.
    private static func getCRAPITestToken() -> String {
        let tokenPath = "/Tests/TestabilityResources/CRAPITestToken.txt"
        let fileManager = FileManager()
        let currentPath = fileManager.currentDirectoryPath
        let path = currentPath + tokenPath
        guard let contents = fileManager.contents(atPath: path),
              let token = String(data: contents, encoding: .utf8)?.removing("\n")
        else {
            // Creates the file `CRAPITestToken.txt` in `/Tests/TestabilityResources/`
            // if it doesn't exist. Just for convenience.
            if !fileManager.fileExists(atPath: path) {
                fileManager.createFile(atPath: path, contents: nil, attributes: nil)
            }
            fatalError(
                "No valid CRAPI tokens found in file `\(path)`"
                    + " Please get a valid token and copy-paste it to that file."
                    + " Read `CRAPIRequest.crapiToken`'s explanation for more info"
            )
        }
        
        return token
    }
    
    /// Must be configured in your Provider's panel. (here, Provider = Twitch)
    private var twitchTestCallbackUrl: String {
        let port = app.http.server.configuration.port
        let host = app.http.server.configuration.hostname
        return "http://\(host):\(port)/twitch/api/v1/oauth/callback"
    }
    
    /// Prepares the app for extra development/test -only stuff.
    func testAndDevelopmentPreparation() throws {
        let env = app.environment
        if env == .testing || env == .development {
            testDict["crapiTestToken"] = Self.getCRAPITestToken()
            testDict["twitchTestCallbackUrl"] = twitchTestCallbackUrl
        }
        if env == .testing {
            // For test purposes, delete everything from
            // the test db, every time Configuration is run.
            try app.autoRevert().wait()
            try app.autoMigrate().wait()
        }
    }
}
