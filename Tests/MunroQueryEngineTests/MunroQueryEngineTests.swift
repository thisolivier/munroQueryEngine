import XCTest
@testable import MunroQueryEngine

final class MunroQueryEngineTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MunroQueryEngine().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
