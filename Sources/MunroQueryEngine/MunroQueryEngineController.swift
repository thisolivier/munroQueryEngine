import Foundation

public protocol MunroQueryEngineControllable {
    func loadCsvData(from url: URL?) throws
    func makeQuery(_ query: MunroQuery) -> Result<[Munro], MunroQueryEngineError>
}

public class MunroQueryEngineController: MunroQueryEngineControllable {

    var dataStore: MunroStorable?
    var queryExecutor: MunroQueryExecutable.Type = MunroQueryExecutor.self
    
    private var defaultDataSetUrl: URL? {
        URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent("defaultMunroData.csv")
    }
    
    public init() {
        self.dataStore = nil
    }
    
    public func loadCsvData(from url: URL? = nil) throws {
        guard let realUrl = url ?? defaultDataSetUrl else {
            throw MunroQueryEngineError.storeError
        }
        self.dataStore = MunroCSVStore(from: realUrl)
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
