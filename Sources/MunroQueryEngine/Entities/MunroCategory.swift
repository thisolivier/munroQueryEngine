//
//  File.swift
//  
//
//  Created by Olivier Butler on 24/03/2021.
//

import Foundation

public enum MunroCategory {
    case munro, top
    
    public init?(string: String) {
        switch string.lowercased() {
        case "mun":
            self = .munro
        case "top":
            self = .top
        default:
            return nil
        }
    }
}
