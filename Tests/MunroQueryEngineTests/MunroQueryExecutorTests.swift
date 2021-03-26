import XCTest
@testable import MunroQueryEngine

final class MunroQueryExecutorTests: XCTestCase {
    
    typealias UnsortedQueryResult = Result<Set<Munro>, MunroQueryEngineError>
    typealias SortedQueryResult = Result<[Munro], MunroQueryEngineError>
    
    static var allTests = [
        ("testExcludesMunrosWithNoCategory", testExcludesMunrosWithNoCategory),
        ("testCorrectNumberOfMunros", testCorrectNumberOfMunros),
        ("testReturnsCorrectCategory", testReturnsCorrectCategory),
        ("testReturnsCorrectCategory", testReturnsCorrectCategory),
        ("testReturnsCorrectHeightRange", testReturnsCorrectHeightRange),
        ("testDescendingNameSorting", testDescendingNameSorting),
        ("testDescendingHeightSorting", testDescendingHeightSorting),
        ("testAscendingHeightSorting", testAscendingHeightSorting)
    ]
    
    func testCorrectNumberOfMunros() {
        guard let query = try? MunroQuery() else {
            return XCTFail("Could not initialise query")
        }
        let testMunros = someRandos.filter { $0.category != nil }
        let testStore = MockMunroStore(munros: testMunros)
        let expectedCount = testMunros.count
        
        guard let queryResult = try? MunroQueryExecutor.execute(query, with: testStore) else {
            return XCTFail("Could not run query")
        }
        
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
        
        let queryResultAsSet = try? MunroQueryExecutor.execute(query, with: testStore)
            .map({ Set($0) })
        
        
        XCTAssertEqual(expectedResult, queryResultAsSet)
    }
    
    func testReturnsCorrectCategory() {
        guard let query = try? MunroQuery(categoryFilter: .top) else {
            return XCTFail("Could not initialise query")
        }
        let testStore = MockMunroStore(munros: someRandos)
        let expectedResult: UnsortedQueryResult = .success(someRandosOnlyTops)
        
        let queryResult = try? MunroQueryExecutor.execute(query, with: testStore).map({ Set($0) })
        
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
        
        let queryResultRange = try? MunroQueryExecutor.execute(rangeQuery, with: testStore).map({ Set($0) })
        let queryResultMaximum = try? MunroQueryExecutor.execute(maximumQuery, with: testStore).map({ Set($0) })
        let queryResultMinimum = try? MunroQueryExecutor.execute(minimumQuery, with: testStore).map({ Set($0) })
        
        XCTAssertEqual(queryResultRange, expectedResultRange)
        XCTAssertEqual(queryResultMaximum, expectedResultMaximum)
        XCTAssertEqual(queryResultMinimum, expectedResultMinimum)
    }
    
    func testDescendingNameSorting() {
        let sorting = MunroQuerySorting(
            order: .descending,
            propertyToSortBy: .name
        )
        guard let query = try? MunroQuery(sorting: sorting) else {
            return XCTFail("Could not initialise query")
        }
        let testStore = MockMunroStore(munros: someRandos)
        let expectedReuslt: SortedQueryResult = .success(someRandosAlphabetical)
        
        let queryResult = try? MunroQueryExecutor.execute(query, with: testStore)
        
        XCTAssertEqual(expectedReuslt, queryResult)
    }
    
    func testDescendingHeightSorting() {
        let sorting = MunroQuerySorting(
            order: .descending,
            propertyToSortBy: .height
        )
        guard let query = try? MunroQuery(sorting: sorting) else {
            return XCTFail("Could not initialise query")
        }
        let testStore = MockMunroStore(munros: someRandos)
        let expectedReuslt: SortedQueryResult = .success(someRandosHeightDecending)
        
        let queryResult = try? MunroQueryExecutor.execute(query, with: testStore)
        
        XCTAssertEqual(expectedReuslt, queryResult)
    }
    
    func testAscendingHeightSorting() {
        let sorting = MunroQuerySorting(
            order: .ascending,
            propertyToSortBy: .height
        )
        guard let query = try? MunroQuery(sorting: sorting) else {
            return XCTFail("Could not initialise query")
        }
        let testStore = MockMunroStore(munros: someRandos)
        let expectedReuslt: SortedQueryResult = .success(someRandosHeightDecending.reversed())
        
        let queryResult = try? MunroQueryExecutor.execute(query, with: testStore)
        
        XCTAssertEqual(expectedReuslt, queryResult)
    }
}

struct MockMunroStore: MunroStorable {
    var munros: Set<Munro>
}
