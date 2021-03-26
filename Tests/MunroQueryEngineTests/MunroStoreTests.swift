import XCTest
@testable import MunroQueryEngine

final class MunroStoreTests: XCTestCase {

    static var allTests = [
        ("testCanMakeStore", testCanMakeStore),
        ("testStoreProvidesCorrectData", testStoreProvidesCorrectData)
    ]
    
    let testFilePathComponent: String = "testMunroCSV.csv"
    let expectedMunros: Set<Munro> = [
        Munro(heightMeters: 1165, category: .munro, name: "Stob Binnein", runningNumber: 6),
        Munro(heightMeters: 1044.9, category: nil, name: "Cruach Ardrain SW Top", runningNumber: 10),
        Munro(heightMeters: 1045.9, category: .munro, name: "Cruach Ardrain", runningNumber: 11)
    ]
    
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
