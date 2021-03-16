import Fluent

extension OAuthTokens {
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> ELF<Void> {
            database.schema(OAuthTokens.schema)
                .id()
                .field(.init(FieldKeys.accessToken), .string)
                .field(.init(FieldKeys.refreshToken), .string)
                .field(.init(FieldKeys.expiresIn), .int)
                .field(.init(FieldKeys.scope), .array(of: .string))
                .field(.init(FieldKeys.tokenType), .string)
                .field(.init(FieldKeys.streamerId), .uuid)
                .field(.init(FieldKeys.issuer), .string)
                .field(.init(FieldKeys.createdAt), .datetime, .required)
                .create()
        }
        
        func revert(on database: Database) -> ELF<Void> {
            database.schema(OAuthTokens.schema)
                .delete()
        }
    }
}

