//
//  File.swift
//  
//
//  Created by Olivier Butler on 26/03/2021.
//

import XCTest
@testable import MunroQueryEngine

final class MunroQueryEngineControllerTests: XCTestCase {
    
    let testFilePathComponent: String = "testMunroCSV.csv"
    
    override func setUp() {
        MockQueryExecutor.queryReceived = nil
        MockQueryExecutor.storeReceived = nil
    }
    
    func testControllerLoadsData() {
        let testController = MunroQueryEngineController()
        let resourceURL = URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent(testFilePathComponent)
        let expectedStoredMunros = munrosBinneinAdrianAdrian
        
        do { try testController.loadCsvData(from: resourceURL) } catch {
            XCTFail("Threw unexpected error \(error)")
        }
        
        guard let csvStore = testController.dataStore as? MunroCSVStore else {
            return XCTFail("Controller made wrong kind of store")
        }
        XCTAssertEqual(csvStore.munros, expectedStoredMunros)
    }
    
    func testControllerLoadsDefaultData() {
        let testController = MunroQueryEngineController()
        
        do { try testController.loadCsvData() } catch {
            XCTFail("Threw unexpected error \(error)")
        }
        
        guard let csvStore = testController.dataStore as? MunroCSVStore else {
            return XCTFail("Controller made wrong kind of store")
        }
        XCTAssertFalse(csvStore.munros.isEmpty)
    }
    
    func testControllerHasQueryExecutor() {
        let testController = MunroQueryEngineController()
        
        XCTAssertTrue(testController.queryExecutor == MunroQueryExecutor.self)
    }
    
    func testControllerExecutesQuery() {
        let testController = MunroQueryEngineController()
        guard let testQuery = try? MunroQuery(minimumHeightMeters: Float.random(in: 0...200), categoryFilter: .munro) else {
            return XCTFail("Could not generate query")
        }
        
        testController.queryExecutor = MockQueryExecutor.self
        testController.makeQuery(testQuery)
        
        XCTAssertEqual(MockQueryExecutor.queryReceived, testQuery)
        XCTAssertNotNil(MockQueryExecutor.storeReceived)
    }
}

enum MockQueryExecutor: MunroQueryExecutable {
    static var queryReceived: MunroQuery?
    static var storeReceived: MunroStorable?
    
    static func execute(_ query: MunroQuery, with store: MunroStorable) throws -> Result<[Munro], MunroQueryEngineError> {
        queryReceived = query
        storeReceived = store
        return .failure(.unknownError)
    }
}
