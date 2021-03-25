//
//  File.swift
//  
//
//  Created by Olivier Butler on 25/03/2021.
//

import Foundation

public struct MunroQuery {
    let heightRange: ClosedRange<Float>?
    let categoryFilter: MunroCategory?
    let sorting: MunroQuerySorting?
    
    public init(
        minimumHeightMeters: Float? = nil,
        maximumHeightMeters: Float? = nil,
        categoryFilter: MunroCategory? = nil,
        sorting: MunroQuerySorting? = nil
    ) throws {
        self.categoryFilter = categoryFilter
        self.sorting = sorting
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
