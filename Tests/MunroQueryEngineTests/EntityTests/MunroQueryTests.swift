import XCTest
@testable import MunroQueryEngine

final class MunroQueryTests: XCTestCase {
    
    static var allTests = [
        ("testHeightRange", testHeightRange),
        ("testInvalidHeightRange", testInvalidHeightRange),
        ("testHeightMinimumOnly", testHeightMinimumOnly),
        ("testHeightMaximumOnly", testHeightMaximumOnly),
        ("testCategoryFilter", testCategoryFilter),
        ("testSorting", testSorting)
    ]
    
    func testEmptyQueryHasNoFilters() {
        guard let query = try? MunroQuery() else {
            return XCTFail("Could not initialise query")
        }
        
        XCTAssertNil(query.categoryFilter)
        XCTAssertNil(query.heightRange)
        XCTAssertNil(query.sorting)
    }
    
    func testHeightRange() {
        let expectedHeightRange: ClosedRange<Float> = Float.random(in: 0..<100)...Float.random(in: 100..<200)
        
        let optionalMunroQuery = try? MunroQuery(minimumHeightMeters: expectedHeightRange.lowerBound, maximumHeightMeters: expectedHeightRange.upperBound)
        
        
        guard let munroQuery = optionalMunroQuery else {
            return XCTFail("Could not initialise query")
        }
        XCTAssertEqual(munroQuery.heightRange, expectedHeightRange)
    }
    
    func testHeightMinimumOnly() {
        let expectedHeightRange: ClosedRange<Float> = Float.random(in: 0..<200)...Float.greatestFiniteMagnitude
        
        let query = try? MunroQuery(minimumHeightMeters: expectedHeightRange.lowerBound, maximumHeightMeters: nil)
        
        XCTAssertEqual(expectedHeightRange, query?.heightRange)
    }
    
    func testHeightMaximumOnly() {
        let expectedHeightRange: ClosedRange<Float> = Float.leastNormalMagnitude...Float.random(in: 0..<200)
        
        let query = try? MunroQuery(minimumHeightMeters: nil, maximumHeightMeters: expectedHeightRange.upperBound)
        
        XCTAssertEqual(expectedHeightRange, query?.heightRange)
    }
    
    func testInvalidHeightRange() {
        let irrationalMinimum: Float = Float.random(in: 100..<200)
        let irrationalMaximum: Float = Float.random(in: 0..<100)
        let expectedError: MunroQueryEngineError = .queryError(.badHeightRange)
        
        let badInitialisationOfQuery: ()throws -> () = {
            _ = try MunroQuery(
                minimumHeightMeters: irrationalMinimum,
                maximumHeightMeters: irrationalMaximum)
        }
        
        XCTAssertThrowsError(
            try badInitialisationOfQuery(),
            "Query should throw error with bad height range"
        ) { error in
            guard let munroQueryError = error as? MunroQueryEngineError else {
                return XCTFail("Unexpected error received. Exprecting MunroQueryError")
            }
            XCTAssertEqual(munroQueryError, expectedError)
        }
    }
    
    func testCategoryFilter() {
        let expectedCategory: MunroCategory = .top
        
        let query = try? MunroQuery(categoryFilter: .top)
        
        XCTAssertEqual(expectedCategory, query?.categoryFilter)
    }
    
    func testSorting() {
        let expectedSorting = MunroQuerySorting(
            order: .ascending,
            propertyToSortBy: .height)
        
        let query = try? MunroQuery(sorting: expectedSorting)
        
        XCTAssertEqual(expectedSorting, query?.sorting)
    }
}
