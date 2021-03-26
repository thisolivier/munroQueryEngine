import XCTest
@testable import MunroQueryEngine

final class MunroCategoryTests: XCTestCase {
    
    static var allTests = [
        ("testMunroCategoryFromString", testMunroCategoryFromString)
    ]
    
    func testMunroCategoryFromString() {
        let input = ["mun", "MUN", "top", "TOp", "", "other", "toppy"]
        let expectedOutput: [MunroCategory?] = [.munro, .munro, .top, .top, nil, nil, nil]
        
        let testCategories = input.map{ MunroCategory(string: $0) }
        
        XCTAssertEqual(testCategories, expectedOutput)
    }
}

