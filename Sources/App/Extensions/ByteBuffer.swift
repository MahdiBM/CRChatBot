import Vapor

extension ByteBuffer {
    /// UTF8 string representation of the content of the ByteBuffer.
    var contentString: String {
        .init(decoding: self.readableBytesView, as: UTF8.self)
    }
}

extension ByteBuffer {
    /// ByteBuffer's content as Data.
    func contentData() -> Data {
        self.getData(at: 0, length: self.readableBytes) ?? Data()
    }
}

extension Optional where Wrapped == ByteBuffer {
    /// Convenience function to get ByteBuffer's content as Data
    /// when the subject is an Optional.
    func contentData() -> Data {
        guard let bytes = self else { return Data() }
        return bytes.getData(at: 0, length: bytes.readableBytes) ?? Data()
    }
}
