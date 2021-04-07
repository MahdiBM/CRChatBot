import Vapor

extension TwitchResponder {
    /// Query Parameters that TwitchResponder works with.
    struct Params: Content {
        let arg1: String?
        let arg2: String?
        let arg3: String?
        let arg4: String?
        let arg5: String?
        let arg6: String?
        let arg7: String?
        let arg8: String?
        let arg9: String?
        // NightBot only accepts up to 9 arguments.
        // Setting up NightBot for more will make it not respond correctly.
        
        init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else {
                throw Responses.noInput
            }
            
            /// Finds value for a given argument. Values must only be strings.
            func findValue(for key: CodingKeys) -> String? {
                if let value = try? container.decode(String.self, forKey: key) {
                    switch value {
                    // If user doesn't input anything for an argument,
                    // nightbot will still populate that argument with `null`.
                    case "null": return nil
                    default: return value
                    }
                }
                else if let value = try? container.decode(Int.self, forKey: key) {
                    return "\(value)"
                }
                else if let value = try? container.decode(Double.self, forKey: key) {
                    return "\(value)"
                }
                else {
                    return nil
                }
            }
            
            self.arg1 = findValue(for: .arg1)
            self.arg2 = findValue(for: .arg2)
            self.arg3 = findValue(for: .arg3)
            self.arg4 = findValue(for: .arg4)
            self.arg5 = findValue(for: .arg5)
            self.arg6 = findValue(for: .arg6)
            self.arg7 = findValue(for: .arg7)
            self.arg8 = findValue(for: .arg8)
            self.arg9 = findValue(for: .arg9)
        }
        
        /// Joins all other values together and returns them as a single string,
        /// starting from, and including the given KeyPath.
        func theRest(startingFrom path: KeyPath<Self, String?>) -> String? {
            guard let index = Self.allCases.firstIndex(of: path) else {
                return nil
            }
            let cases = Array(Self.allCases.dropFirst(index))
            let values = cases.compactMap { path in
                self[keyPath: path]
            }
            guard values.count != 0 else {
                return nil
            }
            let joined = values.joined(separator: " ")
            return joined
        }
        
        /// All KeyPath cases of arguments, in the appropriate order.
        private static var allCases: [KeyPath<Self, String?>] {
            [\Self.arg1, \Self.arg2, \Self.arg3,
             \Self.arg4, \Self.arg5, \Self.arg6,
             \Self.arg7, \Self.arg8, \Self.arg9]
        }
    }
}
