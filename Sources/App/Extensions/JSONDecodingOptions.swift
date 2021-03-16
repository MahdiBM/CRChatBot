import SwiftProtobuf

extension JSONDecodingOptions {
    init(ignoreUnknownFields: Bool?, messageDepthLimit: Int?) {
        self = Self()
        if let ignoreUnknownFields = ignoreUnknownFields {
            self.ignoreUnknownFields = ignoreUnknownFields
        }
        if let messageDepthLimit = messageDepthLimit {
            self.messageDepthLimit = messageDepthLimit
        }
    }
    
    static let ignoringUnknownFields = Self(ignoreUnknownFields: true, messageDepthLimit: nil)
}
