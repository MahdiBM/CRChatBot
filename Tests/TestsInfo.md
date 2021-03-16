

## Why there are seemingly-random `do { }` blocks in some places?

Because `do { }` blocks make a new scope around themselves; by example:
```swift
func testSomething throws() {
    let name = "..."
    .
    .
    .
    
    let name = "..."
    .
    .
    .
}
```
Compiler will complain about the above code because there are 2 `name` variables in one scope.
But:
```swift
func testSomething throws() {
    do {
        let name = "..."
        .
        .
        .
    }
     
    do {
        let name = "..."
        .
        .
        .
    }
}
```
With this new above code, compiler won't complain and everything goes well,
because the 2 `name`s are in different scopes.

Thats mostly the only reason you see those `do { }` blocks in some functions.


## Explanation about tests which might fail without app's fault

Basically, this can happen to any functions that are really calling a foreign API and
not using fake calls.
But, this is mostly only applicable to functions who have a comment at top of them, telling you to
read `## Explanation about tests which might fail without app's fault`
in case of failure.

### info
Indicates that the function might fail at times, but generally should work. 
If the stuff below are causing the problem, then the failure of these functions 
does not really indicate a problem in app's functionality.
### Why do they fail?
The tests most of the times use real async calls to foreign APIs to get real info from there
so the tests are as near to a production state as they can be.

Known reasons that they can fail due to, without it being App's fault:
1- If the foreign API is not responding for whatever reasons.
2- If your internet connection is not good enough and the app can't retrieve
    enough info to make the tests pass.
3- In some tests, you see the function `singleTrophyNumberFromGlobalLeaderboard(app:)`.
    If the trophy output of the functions is not a good trophy; then the tests might fail.
    This might be due to the data retrieved from the Clash Royale  API at that specific time
    that the tests are being run.
    To fix, in the function mentioned, try to lower (or higher) the number 
    in `return Int(items.map(\.trophies)[...])` (min 0, max 999).
    The current number is a good number, but it still fails sometimes.
