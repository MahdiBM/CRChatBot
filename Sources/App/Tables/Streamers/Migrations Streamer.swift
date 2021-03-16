import Fluent

extension Streamers {
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Streamers.schema)
                .id()
                .field(.init(FieldKeys.channelName), .string)
                .field(.init(FieldKeys.lastOnline), .int)
                .field(.init(FieldKeys.isBlacklisted), .bool)
                .field(.init(FieldKeys.performOnlineChecks), .bool)
                .field(.init(FieldKeys.createdAt), .datetime, .required)
                .field(.init(FieldKeys.infoDictionary), .dictionary(of: .string))
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(Streamers.schema)
                .delete()
        }
    }
}
