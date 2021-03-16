
/// Initializes a Type to a default value.
protocol EmptyInitializable {
    init()
}

extension String: EmptyInitializable { }
extension Bool: EmptyInitializable { }
extension Int: EmptyInitializable { }
extension Array: EmptyInitializable { }
