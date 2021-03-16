import Foundation

extension Array where Element: Equatable {
    /// Filter all provided values out of the array.
    /// - Returns: The array with no occurrences of any of the provided values.
    func filterOut(_ values: Element...) -> Self {
        self.filterOut(values)
    }
    
    /// Filter all provided values out of the array.
    /// - Returns: The array with no occurrences of the provided values.
    func filterOut(_ values: [Element]) -> Self {
        self.filter { element in
            !values.map { value in element == value }.contains(true)
        }
    }
}
