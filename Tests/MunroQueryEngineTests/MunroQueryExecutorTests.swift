import XCTest
@testable import MunroQueryEngine

final class MunroQueryExecutorTests: XCTestCase {
    
    typealias UnsortedQueryResult = Result<Set<Munro>, MunroQueryEngineError>
    typealias SortedQueryResult = Result<[Munro], MunroQueryEngineError>
    
    static var allTests = [
        ("testExcludesMunrosWithNoCategory", testExcludesMunrosWithNoCategory),
    ]
    
    func testCorrectNumberOfMunros() {
        guard let query = try? MunroQuery() else {
            return XCTFail("Could not initialise query")
        }
        let testMunros = someRandos.filter { $0.category != nil }
        let testStore = MockMunroStore(munros: testMunros)
        let expectedCount = testMunros.count
        
        let queryResult = MunroQueryExecutor.execute(query, with: testStore)
        
        switch queryResult {
        case .success(let munroArray):
            XCTAssertEqual(expectedCount, munroArray.count)
        case .failure(let error):
            XCTFail("Query threw an error, \(error)")
        }
    }
    
    func testExcludesMunrosWithNoCategory() {
        guard let query = try? MunroQuery() else {
            return XCTFail("Could not initialise query")
        }
        let testMunros = munrosBinneinAdrianAdrian
        let testStore = MockMunroStore(munros: testMunros)
        let expectedResult: UnsortedQueryResult = .success(
            testMunros.filter{ $0.category != nil }
        )
        
        let queryResultAsSet = MunroQueryExecutor.execute(query, with: testStore)
            .map({ Set($0) })
        
        
        XCTAssertEqual(expectedResult, queryResultAsSet)
    }
    
    func testReturnsCorrectCategory() {
        guard let query = try? MunroQuery(categoryFilter: .top) else {
            return XCTFail("Could not initialise query")
        }
        let testStore = MockMunroStore(munros: someRandos)
        let expectedResult: UnsortedQueryResult = .success(someRandosOnlyTops)
        
        let queryResult = MunroQueryExecutor.execute(query, with: testStore).map({ Set($0) })
        
        XCTAssertEqual(expectedResult, queryResult)
    }
    
    func testReturnsCorrectHeightRange() {
        let minimumHeight: Float = 300
        let maximumHeight: Float = 2000
        
        guard
            let rangeQuery = try? MunroQuery(
                minimumHeightMeters: minimumHeight,
                maximumHeightMeters: maximumHeight),
            let minimumQuery = try? MunroQuery(
                minimumHeightMeters: minimumHeight),
            let maximumQuery = try? MunroQuery(
                maximumHeightMeters: maximumHeight
            ) else {
            return XCTFail("Could not initialise query")
        }
        
        let testStore = MockMunroStore(munros: someRandos)
        let expectedResultRange: UnsortedQueryResult = .success(someRandosBelow2000.filter { !someRandosBelow300.contains($0) })
        let expectedResultMinimum: UnsortedQueryResult = .success(
            someRandos
                .filter { $0.category != nil }
                .filter { !someRandosBelow300.contains($0) }
        )
        let expectedResultMaximum: UnsortedQueryResult = .success(someRandosBelow2000)
        
        let queryResultRange = MunroQueryExecutor.execute(rangeQuery, with: testStore).map({ Set($0) })
        let queryResultMaximum = MunroQueryExecutor.execute(maximumQuery, with: testStore).map({ Set($0) })
        let queryResultMinimum = MunroQueryExecutor.execute(minimumQuery, with: testStore).map({ Set($0) })
        
        XCTAssertEqual(queryResultRange, expectedResultRange)
        XCTAssertEqual(queryResultMaximum, expectedResultMaximum)
        XCTAssertEqual(queryResultMinimum, expectedResultMinimum)
    }
}

enum MunroQueryEngineError: Equatable, Error {
    case queryExecutorError, munroCsvStoreError
}

struct MockMunroStore: MunroStorable {
    var munros: Set<Munro>
}
