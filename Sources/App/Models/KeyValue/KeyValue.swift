import Vapor

/// Simple Key & Value pair container.
struct KeyValue: Content, Equatable {
    var key: String
    var value: String
}
