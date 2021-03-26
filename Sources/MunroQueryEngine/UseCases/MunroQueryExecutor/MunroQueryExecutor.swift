//
//  File.swift
//  
//
//  Created by Olivier Butler on 26/03/2021.
//

import Foundation

public protocol MunroQueryExecutable {
    
    static func execute(_ query: MunroQuery, with store: MunroStorable) throws -> Result<[Munro], MunroQueryEngineError>
}

public enum MunroQueryExecutor: MunroQueryExecutable {
    
    public typealias QueryResult = Result<[Munro], MunroQueryEngineError>
    
    public static func execute(_ query: MunroQuery, with store: MunroStorable) throws -> QueryResult {
        let munros = applyDefaultFiltering(to: store.munros)
        let queryOperation = unpackQuery(query)
        return .success(try queryOperation(munros))
    }
    
    private static func applyDefaultFiltering(to munroSet: Set<Munro>) -> Set<Munro> {
        return munroSet.filter({ $0.category != nil })
    }
    
    private static func unpackQuery(_ query: MunroQuery) -> ((_: Set<Munro>) throws -> [Munro]) {
        var filterOperations: [(_: Set<Munro>) -> Set<Munro>] = []
        var sortingOperations: [(_: [Munro]) throws -> [Munro]] = []
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
        if let sorting = query.sorting {
            switch sorting.propertyToSortBy {
            case .height:
                sortingOperations.append({ $0.sorted { (first, second) -> Bool in
                    let isTaller = first.heightMeters > second.heightMeters
                    switch sorting.order {
                    case .ascending:
                        return !isTaller
                    case .descending:
                        return isTaller
                    }
                }})
            case .name:
                sortingOperations.append({ $0.sorted { (first, second) -> Bool in
                    let isHigherInAlphabet = first.name < second.name
                    switch sorting.order {
                    case .ascending:
                        return !isHigherInAlphabet
                    case .descending:
                        return isHigherInAlphabet
                    }
                }})
            case .nestedSort(let nested):
                sortingOperations.append { _ in throw MunroQueryEngineError.queryError(.nestedSortNotYetSupported) }
            }
        }
        
        return { set in
            var mutableSet = set
            for filter in filterOperations { mutableSet = filter(set) }
            var mutableArray = Array(mutableSet)
            for sort in sortingOperations { mutableArray = try sort(mutableArray) }
            return mutableArray
        }
    }
}
