import Vapor

//MARK: - Equatable Conformance

extension UserRequests: Equatable {
    public static func == (lhs: UserRequests, rhs: UserRequests) -> Bool {
        lhs.username == rhs.username
            && lhs.timestamp == rhs.timestamp
            && lhs.description == rhs.description
    }
}
