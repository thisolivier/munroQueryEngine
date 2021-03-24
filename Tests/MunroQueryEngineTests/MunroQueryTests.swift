import XCTest
@testable import MunroQueryEngine

final class MunroQueryTests: XCTestCase {
    
    func testMunroQueryHeightRange() {
        let expectedHeightRange: Range<Float>
        
        let munroQuery = MunroQuery(heightRange: Range<Float>)
        
        XCTAssertEqual(munroQuery.heightRange, expectedHeightRange)
    }

    static var allTests = [
        ("testMunroQueryHeightRange", testMunroQueryHeightRange),
    ]
}

struct MunroQuery {
    
}
