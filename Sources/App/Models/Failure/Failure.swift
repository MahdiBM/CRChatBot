import Vapor

/// Custom Failures to throw in case of error.
enum Failure: AbortError {
    case missingValidJson
    case notUnique
    case noOAuthTokensFound
    case requiredParamMissing(_ paramName: String)
    case invalidParam(_ paramName: String)
    case failed
    
    var reason: String {
        switch self {
        case .missingValidJson: return "A valid Json is missing."
        case .notUnique: return "Not unique."
        case .noOAuthTokensFound: return "Could not find any OAuth Tokens."
        case .requiredParamMissing(let paramName): return "Required parameter `\(paramName)` is missing."
        case .invalidParam(let paramName): return "Parameter `\(paramName)` is invalid for this request."
        case .failed: return "Failed"
        }
    }
    
    var status: HTTPResponseStatus {
        .badRequest
    }
}
