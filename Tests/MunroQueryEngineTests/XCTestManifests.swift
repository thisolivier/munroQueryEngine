import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MunroTests.allTests),
        testCase(MunroQueryTests.allTests)
    ]
}
#endif
