import Foundation

enum RandomStringScopes: CaseIterable {
    case uppercaseLetters
    case lowercaseLetters
    case numbers
    
    fileprivate var correspondingStrings: [String] {
        switch self {
        case .uppercaseLetters: return ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        case .lowercaseLetters: return Self.uppercaseLetters.correspondingStrings.map {$0.lowercased()}
        case .numbers: return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        }
    }
}

extension String {
    /// Creates a random string.
    /// - Parameters:
    ///   - length: length of the string.
    ///   - scopes: scopes to be used to create the random string.
    /// - Returns: a random string.
    static func random(length: Int, using scopes: [RandomStringScopes] = RandomStringScopes.allCases) -> String {
        let scopes = scopes == [] ? RandomStringScopes.allCases : scopes
        let strings = scopes.map(\.correspondingStrings).reduce(into: [String]()) {
            $0 += $1
        }
        var randomStrings = [String]()
        (0..<length).forEach { _ in
            let randomInt = Int.random(in: strings.indices)
            randomStrings.append(strings[randomInt])
        }
        return randomStrings.joined()
    }
}

enum TypingLanguage {
    case latin
    case arabic
    case mandarin
    case russian
    
    init? (_ string: String) {
        switch string.lowercased() {
        case "chinese", "japanese", "korean", "mandarin":
            self = .mandarin
        case "arabic", "persian", "farsi":
            self = .arabic
        case "latin", "english":
            self = .latin
        case "russian", "cyrillic":
            self = .russian
        default: return nil
        }
    }
    
    /// regex range of characters.
    fileprivate var range: String {
        switch self {
        case .latin: return "\\p{Latin}"
        case .arabic: return "\\p{Arabic}"
        case .mandarin: return "\\p{Han}"
        case .russian: return "\\p{Cyrillic}"
        }
    }
}

extension String {
    /// Checks if a string meets the requirement to be
    /// identified as a string which contains the specified language.
    func contains(language: TypingLanguage) -> Bool {
        self.range(of: language.range, options: .regularExpression) != nil
    }
}

extension String {
    /// Removes all occurrences of all input strings.
    /// - Parameter strings: strings to be removed.
    /// - Returns: a string without any occurrences of the input strings.
    func removing(_ strings: String...) -> String {
        var newValue = self
        strings.forEach { string in
            newValue = newValue.replacingOccurrences(of: string, with: "")
        }
        return newValue
    }
}

extension String {
    /// Removes the character which exists at the provided index.
    func remove(at index: Int) -> String {
        var arrayOfChars = self.map { String($0) }
        arrayOfChars.remove(at: index)
        return arrayOfChars.joined(separator: "")
    }
}

extension String {
    /// Case-insensitively finds the trailing index
    /// of the first occurrence of the input sub-string.
    func firstTrailingIndex(of subString: String) -> Int? {
        let subStringArray = subString.uppercased().map {$0}
        let subStringLength = subString.count
        let selfArray = self.uppercased().map {$0}
        let range = (selfArray.count - subStringLength + 1)
        guard range > 0 else { return nil }
        
        for idx in 0..<range {
            var newSubString = ""
            
            for index in subStringArray.indices {
                newSubString.append(selfArray[index + idx])
            }
            
            if newSubString == subString.uppercased() {
                return (idx + subStringLength - 1)
            }
        }
        
        return nil
    }
}
