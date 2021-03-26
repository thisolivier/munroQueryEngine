//
//  File.swift
//  
//
//  Created by Olivier Butler on 26/03/2021.
//

import Foundation

protocol MunroQueryExecutable {
    
    static func execute(_ query: MunroQuery, with store: MunroStorable) -> Result<[Munro], MunroQueryEngineError>
}

enum MunroQueryExecutor: MunroQueryExecutable {
    
    typealias QueryResult = Result<[Munro], MunroQueryEngineError>
    
    static func execute(_ query: MunroQuery, with store: MunroStorable) -> QueryResult {
        let munros = applyDefaultFiltering(to: store.munros)
        let queryOperation = unpackQuery(query)
        return .success(queryOperation(munros))
    }
    
    private static func applyDefaultFiltering(to munroSet: Set<Munro>) -> Set<Munro> {
        return munroSet.filter({ $0.category != nil })
    }
    
    private static func unpackQuery(_ query: MunroQuery) -> ((_: Set<Munro>) -> [Munro]) {
        var filterOperations: [(_: Set<Munro>) -> Set<Munro>] = []
        if let categoryFilter = query.categoryFilter {
            filterOperations.append({ set in
                set.filter { $0.category == categoryFilter }
            })
        }
        
        if let heightRange = query.heightRange {
            filterOperations.append({ set in
                set.filter { heightRange.contains($0.heightMeters) }
            })
        }
        
        return { set in
            var mutableSet = set
            for filter in filterOperations { mutableSet = filter(set) }
            return Array(mutableSet)
        }
    }

}
