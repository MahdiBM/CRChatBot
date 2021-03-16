import Foundation

extension FileManager {
    /// Tries to save the value as a String to a file at the provided path.
    /// - Parameters:
    ///   - path: where the file should be made, relative to this
    ///   project's path. Should include file's extension.
    func saveAsJSONString<Value>(_ encodableValue: Value, relativePath: String)
    throws where Value: Encodable {
        let encoder = JSONEncoder()
        let data = try encoder.encode(encodableValue)
        let string = String(data: data, encoding: .utf8)!
        let currentPath = self.currentDirectoryPath
        let path = currentPath + relativePath
        if !self.fileExists(atPath: path) {
            self.createFile(atPath: path, contents: nil)
        }
        try string.write(toFile: path, atomically: false, encoding: .utf8)
    }
}
