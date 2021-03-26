//
//  File.swift
//  
//
//  Created by Olivier Butler on 26/03/2021.
//

import Foundation

public enum MunroQueryEngineError: Equatable, Error {
    case queryError(MunroQueryError), storeError
}

public enum MunroQueryError: Error {
    case badHeightRange, nestedSortNotYetSupported
}
