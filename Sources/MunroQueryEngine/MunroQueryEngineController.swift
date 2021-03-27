import Foundation

public protocol MunroQueryEngineControllable {
    func loadCsvData(from url: URL?) throws
    func makeQuery(_ query: MunroQuery) -> Result<[Munro], MunroQueryEngineError>
}

public class MunroQueryEngineController: MunroQueryEngineControllable {

    var dataStore: MunroStorable?
    var queryExecutor: MunroQueryExecutable.Type = MunroQueryExecutor.self
    
    public init() {
        self.dataStore = nil
    }
    
    public func loadCsvData(from url: URL? = nil) throws {
        let backupUrl = Bundle.module.url(forResource: "defaultMunroData", withExtension: "csv")!
        self.dataStore = MunroCSVStore(from: url ?? backupUrl)
    }
    
    public func makeQuery(_ query: MunroQuery) -> Result<[Munro], MunroQueryEngineError> {
        if dataStore == nil {
            do { try loadCsvData() } catch {
                return .failure(.storeError)
            }
        }
        do { return try queryExecutor.execute(query, with: dataStore!)
        } catch {
            guard let munroError = error as? MunroQueryEngineError else {
                return .failure(.unknownError)
            }
            return .failure(munroError)
        }
    }
}
