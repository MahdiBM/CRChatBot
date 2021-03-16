import Fluent

extension UserRequests {
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(UserRequests.schema)
                .id()
                .field(.init(FieldKeys.username), .string)
                .field(.init(FieldKeys.timestamp), .int)
                .field(.init(FieldKeys.description), .string)
                .field(.init(FieldKeys.streamerId), .uuid, .references(Streamers.schema, .id))
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(UserRequests.schema)
                .delete()
        }
    }
}
