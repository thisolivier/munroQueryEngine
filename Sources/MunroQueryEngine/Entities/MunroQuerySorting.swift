//
//  File.swift
//  
//
//  Created by Olivier Butler on 25/03/2021.
//

import Foundation

public struct MunroQuerySorting: Equatable {
    
    public enum SortingOrder: Equatable {
        case ascending, descending
    }

    public enum SortingProperty: Equatable {
        case height, name
        indirect case nestedSort([SortingProperty])
    }

    let order: SortingOrder
    let propertyToSortBy: SortingProperty
}
