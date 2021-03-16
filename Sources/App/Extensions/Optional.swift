import Foundation

enum OptionalError: Error {
    case NilValue
}

extension Optional {
    /// Tries to unwrap and throws `OptionalError.NilValue` in case of a nil value.
    /// - Throws: `OptionalError.NilValue` in case of nil.
    /// - Returns: unwrapped value of the Optional value.
    func throwingUnwrap() throws -> Wrapped {
        guard let wrappedValue = self else {
            throw OptionalError.NilValue
        }
        return wrappedValue
    }
}
