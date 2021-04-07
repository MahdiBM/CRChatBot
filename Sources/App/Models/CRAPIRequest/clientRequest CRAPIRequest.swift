import Vapor

extension CRAPIRequest {
    /// Clash Royale API Bearer token.
    /// You can get yours from https://developer.clashroyale.com .
    /// Using Clash Royale official API is free for life,
    /// but you must follow their Fan Content Policy @ https://supercell.com/en/fan-content-policy
    private static let crapiToken = <#Clash Royale API token#>
    
    /// Request from CRAPI using self's value.
    var clientRequest: ClientRequest {
        var clientRequest = ClientRequest()
        clientRequest.url = .init(string: Self.baseUrl + self.urlSuffix)
        let testToken = testDict["crapiTestToken"] as? String
        let token = testToken ?? Self.crapiToken
        let authHeader: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        clientRequest.headers = authHeader
        
        return clientRequest
    }
    
    /// Request from CRAPI with help of manipulating url of a request
    /// that has been made to the `twitch/api/v1/crapi` endpoint.
    static func clientRequest(using url: String) -> ClientRequest {
        var clientRequest = ClientRequest()
        let urlSuffix = url.components(separatedBy: "twitch/api/v1/crapi/").last ?? ""
        clientRequest.url = .init(string: Self.baseUrl + urlSuffix)
        let token = testDict["crapiTestToken"] ?? Self.crapiToken
        let authHeader: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        clientRequest.headers = authHeader
        
        return clientRequest
    }
}
