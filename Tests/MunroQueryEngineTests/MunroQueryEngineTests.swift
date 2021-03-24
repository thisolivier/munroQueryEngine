import XCTest
@testable import MunroQueryEngine

// For the purposes of brevity I'm only going to test & initialise the core properties we care about.
final class MunroQueryEngineTests: XCTestCase {
    
    func testMunro_height() {
        let expectedHeight: Float = Float.random(in: -10000..<10000)
        
        let munro = Munro(heightMeters: expectedHeight)
        
        XCTAssertEqual(munro.heightMeters, expectedHeight)
    }
    
    func testMunro_category() {
        let munroCateogry: MunroCategory = .either
        
        let munro = 
    }

    static var allTests = [
        ("testMunro_height", testMunro_height),
    ]
}

struct Munro {
    let heightMeters: Float
    let category: MunroCategory?
}

enum MunroCategory {
    case munro, top, either
}
