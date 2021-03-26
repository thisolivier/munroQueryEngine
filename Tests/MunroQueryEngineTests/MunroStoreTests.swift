import XCTest
@testable import MunroQueryEngine

final class MunroStoreTests: XCTestCase {

    static var allTests = [
        ("testCanMakeStore", testCanMakeStore),
        ("testStoreProvidesCorrectData", testStoreProvidesCorrectData)
    ]
    
    let expectedMunros: Set<Munro> = munrosBinneinAdrianAdrian
    let testFilePathComponent: String = "testMunroCSV.csv"
    
    func testCanMakeStore() {
        let store: MunroStorable = MunroCSVStore(from: URL(fileURLWithPath: ""))
        
        XCTAssertNotNil(store)
    }
    
    // Should prooobably make more of the methods in the store public unit test it in more detail
    func testStoreProvidesCorrectData() {
        let resourceURL = URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent(testFilePathComponent)
        let store: MunroStorable = MunroCSVStore(from: resourceURL)
        
        XCTAssertEqual(expectedMunros, store.munros)
    }
}
