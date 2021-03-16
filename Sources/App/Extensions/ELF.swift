import Vapor

typealias ELF = EventLoopFuture

extension ELF {
    /// A version of `.flatMap` which can throw as well.
    func tryFlatMap<NewValue>(
        file: StaticString = #file,
        line: UInt = #line,
        _ callback: @escaping (Value) throws -> ELF<NewValue>
    ) -> ELF<NewValue> {
        flatMap(file: file, line: line) { result in
            do {
                return try callback(result)
            } catch {
                return self.eventLoop.makeFailedFuture(error, file: file, line: line)
            }
        }
    }
}
