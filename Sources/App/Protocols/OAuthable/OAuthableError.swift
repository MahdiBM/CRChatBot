import Vapor

/// Errors that might be thrown by OAuthable's functions.
enum OAuthableError: AbortError {
    case providerError(status: HTTPStatus, error: String?)
    case internalFailure(reason: InternalFailureReason)
    case invalidCookie
    
    var reason: String {
        switch self {
        case .providerError(_, let error):
            return "Provider failed with the following message: \(String(describing: error))"
        case .internalFailure(let reason):
            return "Servers internally failed with the following message: \(reason.description)"
        case .invalidCookie:
            return "Could not approve the legitimacy of your request. Please use a web"
                + " browser that allows cookies, or enable cookies for this website."
        }
    }
    
    var status: HTTPResponseStatus {
        switch self {
        case .providerError(let status, _): return status
        case .internalFailure: return .internalServerError
        case .invalidCookie: return .badRequest
        }
    }
}

extension OAuthableError {
    /// Reasons for an internal failure.
    enum InternalFailureReason {
        case queryParametersEncodeError(policy: QueryParametersPolicy)
        
        fileprivate var description: String {
            switch self {
            case .queryParametersEncodeError(let policy):
                return "Failed to encode query parameters into"
                    + " the request using policy `\(policy.rawValue)`."
            }
        }
    }
}
