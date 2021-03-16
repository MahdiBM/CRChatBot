@testable import App
import XCTVapor

final class DecodeNilableTests: XCTestCase {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    private struct DecodeNilableUser: EmptyInitializable, Codable {
        @DecodeNilable var name: String
        @DecodeNilable var familyName: String
    }
    
    private struct NormalUser: Codable {
        var name: String
        var familyName: String
    }
    
    func testDecodeAbility() throws {
        
        let userWithoutName = "{\"familyName\":\"Bahrami\"}"
        
        // Test DecodeNilable instance and make sure it doesn't fail even
        // if there is no `name` in the JSON and there is only `familyName`
        do {
            let encodedUser = userWithoutName.data(using: .utf8)!
            let decodedUser = try decoder.decode(DecodeNilableUser.self, from: encodedUser)
            XCTAssertEqual(decodedUser.name, "")
            XCTAssertEqual(decodedUser.familyName, "Bahrami")
        }
        
        // Test a normal instance and make sure it does fail when there
        // is no `name` in the JSON and there is only `familyName`
        do {
            let encodedUser = userWithoutName.data(using: .utf8)!
            XCTAssertThrowsError(try decoder.decode(NormalUser.self, from: encodedUser))
        }
        
    }
    
    func testEncodeAbility() throws {
        let decodeNilableUser = DecodeNilableUser
            .init(name: .init(wrappedValue: "Mahdi"),
                  familyName: .init(wrappedValue: "Bahrami"))
        
        // If an instance of decodeNilable user which uses `DecodeNilable`
        // protocol gets encoded to data, and then the encode from Data to
        // an instance of a normal Codable model like `NormalUser` is
        // successful, then it means that DecodeNilable values are getting
        // encoded the right way.
        do {
            let encodedUser = try encoder.encode(decodeNilableUser)
            let decodedUser = try decoder.decode(NormalUser.self, from: encodedUser)
            XCTAssertEqual(decodedUser.name, "Mahdi")
            XCTAssertEqual(decodedUser.familyName, "Bahrami")
        }
        
    }
    
}
