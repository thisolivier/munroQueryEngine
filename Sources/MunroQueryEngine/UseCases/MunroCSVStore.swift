//
//  File.swift
//  
//
//  Created by Olivier Butler on 26/03/2021.
//

import Foundation

public class MunroCSVStore: MunroStorable {
    
    public let munros: Set<Munro>
    
    public init(from filePath: URL) {
        let munroArray = Self.loadDataFromFile(location: filePath).compactMap(Self.makeMunro)
        self.munros = Set(munroArray)
    }
    
    private static func makeMunro(from orderedStrings: [String]) -> Munro? {
        guard
            orderedStrings.count >= 28,
            let runningNumber: UInt = UInt(orderedStrings[0]),
            let height: Float = Float(orderedStrings[9])
        else { return nil }
        let name: String = orderedStrings[5]
            .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        let category: MunroCategory? = MunroCategory(string: orderedStrings[27])
        return Munro(
            heightMeters: height,
            category: category,
            name: name,
            runningNumber: runningNumber
        )
    }
    
    private static func loadDataFromFile(location: URL) -> [[String]] {
        guard let stringContents = try? String(contentsOf: location, encoding: .utf8) else {
            return []
        }
        return stringContents
            .components(separatedBy: NSCharacterSet.newlines)
            .filter({ !$0.isEmpty })
            .compactMap( Self.mapRowToColums )
    }
    
    private static func mapRowToColums(_ row: String) -> [String] {
        guard row.contains("\"") else {
            return row.components(separatedBy: ",")
        }
        
        // The following code allows for cells containing strings with commas
        var columns: [String] = []
        let roughColumnsEnumerated = row.components(separatedBy: ",")
            .enumerated()
        let stringColumnStartIndices: [Int] = roughColumnsEnumerated
            .filter({ $1.first == "\"" })
            .map({ $0.offset })
        let stringColumnEndIndices: [Int] = roughColumnsEnumerated
            .filter({ $1.last == "\"" && !$1.hasSuffix("\\\"") })
            .map({ $0.offset })
        
        var dealingWithUnendedString = false
        for (index, roughColumn) in roughColumnsEnumerated {
            if dealingWithUnendedString {
                // We passed the start of a string and haven't yet reached the end
                // So don't make a new col, just append to the last one
                let newValue = columns.last ?? "" + roughColumn
                columns[columns.count - 1] = newValue
            } else {
                // We haven't passed the start of a string, so just append
                columns.append(roughColumn)
            }
            // The following will simply turn on and off the string flag for a string that occupies only one column.
            if stringColumnStartIndices.contains(index)  {
                dealingWithUnendedString = true
            }
            if stringColumnEndIndices.contains(index) {
                dealingWithUnendedString = false
            }
        }
        
        return columns
    }
}
