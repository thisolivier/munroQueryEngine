import XCTest
@testable import MunroQueryEngine

final class MunroQuerySortingTests: XCTestCase {
    
    static var allTests = [
        ("testMunroQuerySorting", testMunroQuerySorting)
    ]
    
    func testMunroQuerySorting() {
        let expectedOrder: MunroQuerySorting.SortingOrder = .ascending
        let expectedSortingProperty: MunroQuerySorting.SortingProperty = .height
        
        let sorting = MunroQuerySorting(
            order: expectedOrder,
            propertyToSortBy: expectedSortingProperty)
        
        XCTAssertEqual(expectedOrder, sorting.order)
        XCTAssertEqual(expectedSortingProperty, sorting.propertyToSortBy)
    }
    
    func testMunroQueryNestedSorting() {
        let expectedSortingProperty: MunroQuerySorting.SortingProperty = .nestedSort([.height, .name])
        
        let sorting = MunroQuerySorting(
            order: .ascending,
            propertyToSortBy: expectedSortingProperty)
        
        XCTAssertEqual(expectedSortingProperty, sorting.propertyToSortBy)
    }
}

