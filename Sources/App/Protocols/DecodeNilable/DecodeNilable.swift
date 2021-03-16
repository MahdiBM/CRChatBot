import Foundation

// Inspired by John Sundell's article
// @ https://www.swiftbysundell.com/tips/default-decoding-values

/// Decodes values, assigning the value of their `.init()`
/// to them if the decode process is unsuccessful.
@propertyWrapper
struct DecodeNilable<Model> where Model: EmptyInitializable & Codable {
    var wrappedValue: Model = .init()
}

extension DecodeNilable: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Model.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    func decode<Model>(_ type: DecodeNilable<Model>.Type, forKey key: Key)
    throws -> DecodeNilable<Model> where Model: EmptyInitializable & Codable {
        try self.decodeIfPresent(type, forKey: key) ?? .init()
    }
}

extension DecodeNilable: CustomStringConvertible {
    var description: String { .init(reflecting: wrappedValue) }
}

extension DecodeNilable: Equatable where Model: Equatable { }

//MARK: -Some Examples
/*
extension String: EmptyInitializable {}

struct MyModel1: Codable {
    var name: String = ""
    //if Codable fails to find a value with coding-key of "name",
    //it will throw an error
}

struct MyModel2: Codable {
    var name: String? = ""
    //if Codable fails to find a value with coding-key of "name",
    //it will assign `nil` to name
}

struct MyModel3: Codable {
    @DecodeNillable var name: String = ""
    //if Codable fails to find a value with coding-key of "name",
    //it will assign value of .init() to name
    //in this case we have an String, and
    //String.init() is equal to ""
    //so name will be equal to `""` if Codable fails
}
*/

