import Vapor

extension BasicAuthorization: Equatable {
    /// Equatable conformance for BasicAuthorization.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.username == rhs.username
            && lhs.password == rhs.password
    }
}
