import XCTest
@testable import MunroQueryEngine

// For the purposes of brevity I'm only going to test & initialise the core properties we care about.
final class MunroTests: XCTestCase {
    
    func testMunro() {
        let expectedHeight: Float = Float.random(in: -10000..<10000)
        let expectedName: String = UUID().uuidString
        let expectedCategory: MunroCategory = .either
        let expectedRunningNumber: UInt = UInt.random(in: 0..<100000)
        
        let munro = Munro(
            heightMeters: expectedHeight,
            category: expectedCategory,
            name: expectedName,
            runningNumber: expectedRunningNumber)
        
        XCTAssertEqual(munro.heightMeters, expectedHeight)
        XCTAssertEqual(munro.category, expectedCategory)
        XCTAssertEqual(munro.name, expectedName)
        XCTAssertEqual(munro.runningNumber, expectedRunningNumber)
    }

    static var allTests = [
        ("testMunro", testMunro),
    ]
}
