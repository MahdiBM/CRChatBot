import XCTVapor

extension XCTestCase {
    /// Blocks and waits for the given time.
    func wait(seconds time: TimeInterval) {
        guard time >= 0 else { return }
        let dateString = Date().debugDescription
        let queue = DispatchQueue(label: "WaiterAtDate:" + dateString)
        let expectation = expectation(description: "ExpectationSetAtDate:" + dateString)
        let nanoFactor: Double = 1000_000_000
        let nanoseconds = Int(time * nanoFactor)
        let dispatchTimeNow = DispatchTime.now()
        let dispatchInterval: DispatchTimeInterval = .nanoseconds(nanoseconds)
        let dispatchTime = dispatchTimeNow.advanced(by: dispatchInterval)
        // `waitForExpectations(timeout:handler:)` function waits for the
        // expectation to be met up to the time passed as `timeout` parameter.
        // Here we setup a queue to make the expectation to be met after the
        // amount of time that is passed to this func as `seconds`.
        // The `waitForExpectations(timeout:handler:)` func's `timeout`
        // needs to be any amount of time higher than the `seconds` passed to
        // this func, so the `waitForExpectations(timeout:handler:)` doesn't
        // throw a failure indicating that the expectation wasn't met in-time.
        // The wait ends right-away after the expectation is fulfilled.
        queue.asyncAfter(deadline: dispatchTime) { expectation.fulfill() }
        let sometimeMoreThanTheEnteredTime = time + 1
        waitForExpectations(timeout: sometimeMoreThanTheEnteredTime, handler: nil)
    }
}
