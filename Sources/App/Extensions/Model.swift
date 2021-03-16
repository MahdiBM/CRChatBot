import Vapor
import Fluent

extension Model where Self: Content {
    /// Registers some basic useful routes for a Model.
    static func registerBaseRoutes(routesBuilder builder: RoutesBuilder) {
        
        // Returns a Page containing all of the values.
        builder.get("all") { req -> ELF<Page<Self>> in
            return Self.query(on: req.db)
                .paginate(for: req)
        }
        
        // Saves a new Model to the database.
        // Returns HTTPStatus.created in case of success.
        builder.post("save") { req -> ELF<HTTPStatus> in
            let content = try req.content.decode(Self.self)
            return content.save(on: req.db)
                .transform(to: HTTPStatus.created)
        }
        
        // Deletes a value from the database, if only one value is found.
        // Currently only works with Fields that have a value of String.
        // Returns HTTPStatus.ok in case of success.
        builder.delete("delete") { req -> ELF<HTTPStatus> in
            let keyValue = try req.query.decode(KeyValue.self)
            return Self.query(on: req.db)
                .filter(FieldKey(stringLiteral: keyValue.key), .equal, keyValue.value)
                .all()
                .flatMapThrowing { all -> Self in
                    guard all.count == 1 else {
                        throw Failure.notUnique
                    }
                    return all.first!
                }
                .flatMap { $0.delete(on: req.db) }
                .transform(to: HTTPStatus.ok)
        }
        
        // Filters values using the provided filter arguments.
        // Currently only works with Fields that have a value of String.
        // Returns a Page of all filtered values.
        builder.get("filter") { req -> ELF<Page<Self>> in
            let keyValue = try req.query.decode(KeyValue.self)
            return Self.query(on: req.db)
                .filter(FieldKey(stringLiteral: keyValue.key), .equal, keyValue.value)
                .paginate(for: req)
        }
        
        // Finds a value using provided filter arguments.
        // Currently only works with Fields that have a value of String.
        // Returns the value.
        builder.get("find") { req -> ELF<Self> in
            let filterer = try req.query.decode(KeyValue.self)
            return Self.query(on: req.db)
                .filter(FieldKey(stringLiteral: filterer.key), .equal, filterer.value)
                .first()
                .unwrap(or: Abort(HTTPStatus.noContent))
        }
        
        // Returns the count of all of the values saved to database.
        builder.get("count") { req -> ELF<Int> in
            return Self.query(on: req.db).count()
        }
    }
}

