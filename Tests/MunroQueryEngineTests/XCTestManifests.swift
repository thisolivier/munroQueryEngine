import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MunroTests.allTests),
        testCase(MunroQueryTests.allTests),
        testCase(MunroQuerySortingTests.allTests),
        testCase(MunroStoreTests.allTests),
        testCase(MunroCategoryTests.allTests)
    ]
}
#endif
