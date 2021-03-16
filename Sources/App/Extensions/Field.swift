import Fluent

extension FieldProperty {
    /// Initializes an instance of FieldProperty.
    /// - Parameter key: A value conforming to RawRepresentable where RawValue is String.
    convenience init<Value>(key: Value)
    where Value: RawRepresentable, Value.RawValue == String {
        self.init(key: .init(stringLiteral: key.rawValue))
    }
}

extension FieldKey {
    /// Initializes an instance of FieldKey.
    /// - Parameter key: A value conforming to RawRepresentable where RawValue is String.
    init<Value>(_ key: Value)
    where Value: RawRepresentable, Value.RawValue == String {
        self.init(stringLiteral: key.rawValue)
    }
}
