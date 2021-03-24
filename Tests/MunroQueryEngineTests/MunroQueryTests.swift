import XCTest
@testable import MunroQueryEngine

final class MunroQueryTests: XCTestCase {
    
    func testHeightRange() {
        let expectedHeightRange: ClosedRange<Float> = Float.random(in: 0..<100)...Float.random(in: 100..<200)
        
        let munroQuery = try? MunroQuery(minimumHeightMeters: expectedHeightRange.lowerBound, maximumHeightMeters: expectedHeightRange.upperBound)
        
        
        guard let realQuery = munroQuery else {
            return XCTFail("Could not initialise query")
        }
        XCTAssertEqual(realQuery.heightRange, expectedHeightRange)
    }
    
    func testInvalidHeightRange() {
        let irrationalMinimum: Float = Float.random(in: 100..<200)
        let irrationalMaximum: Float = Float.random(in: 0..<100)
        let expectedError: MunroQueryError = .badHeightRange
        
        let badInitialisationOfQuery: ()throws -> () = {
            _ = try MunroQuery(
                minimumHeightMeters: irrationalMinimum,
                maximumHeightMeters: irrationalMaximum)
        }
        
        XCTAssertThrowsError(
            try badInitialisationOfQuery(),
            "Query should throw error with bad height range"
        ) { error in
            guard let munroQueryError = error as? MunroQueryError else {
                return XCTFail("Unexpected error received. Exprecting MunroQueryError")
            }
            XCTAssertEqual(munroQueryError, expectedError)
        }
    }

    static var allTests = [
        ("testHeightRange", testHeightRange),
        ("testInvalidHeightRange", testInvalidHeightRange)
    ]
}

struct MunroQuery {
    let heightRange: ClosedRange<Float>?
    
    init(minimumHeightMeters: Float?, maximumHeightMeters: Float?) throws {
        switch (minimumHeightMeters, maximumHeightMeters) {
        case let (.some(lowerHeight), .some(upperHeight)) where lowerHeight <= upperHeight:
            heightRange = lowerHeight...upperHeight
        case (.some(_), .some(_)):
            throw MunroQueryError.badHeightRange
        case let (nil, .some(upperHeight)):
            heightRange = Float.leastNormalMagnitude...upperHeight
        case let (.some(lowerHeight), nil):
            heightRange = lowerHeight...Float.greatestFiniteMagnitude
        case (nil, nil):
            heightRange = nil
        }
    }
}

enum MunroQueryError: Error {
    case badHeightRange
}
