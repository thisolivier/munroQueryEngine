//
//  File.swift
//  
//
//  Created by Olivier Butler on 26/03/2021.
//  Contains expected values correlating to the CSV file, and their location
//

import Foundation
@testable import MunroQueryEngine

let munrosBinneinAdrianAdrian: Set<Munro> = [
    Munro(heightMeters: 1165, category: .munro, name: "Stob Binnein", runningNumber: 6),
    Munro(heightMeters: 1044.9, category: nil, name: "Cruach Ardrain SW Top", runningNumber: 10),
    Munro(heightMeters: 1045.9, category: .munro, name: "Cruach Ardrain", runningNumber: 11)
]

let someRandos: Set<Munro> = [
    Munro(heightMeters: 1165, category: .munro, name: "Stob Binnein", runningNumber: 6),
    Munro(heightMeters: 1044.9, category: nil, name: "Cruach Ardrain SW Top", runningNumber: 10),
    Munro(heightMeters: 1045.9, category: .munro, name: "Cruach Ardrain", runningNumber: 11),
    Munro(heightMeters: 567.2, category: .top, name: "Botch the Grand", runningNumber: 2225),
    Munro(heightMeters: 3876, category: .top, name: "Probably too tall", runningNumber: 2226),
    Munro(heightMeters: 206, category: .munro, name: "Sandrascal Counterhue", runningNumber: 2227),
    Munro(heightMeters: 111.2, category: .munro, name: "Jolly Ratchet", runningNumber: 2228),
]

// Possible results (Excludes nil category values)

let someRandosOnlyTops: Set<Munro> = [
    Munro(heightMeters: 567.2, category: .top, name: "Botch the Grand", runningNumber: 2225),
    Munro(heightMeters: 3876, category: .top, name: "Probably too tall", runningNumber: 2226),
]

let someRandosBelow300: Set<Munro> = [
    Munro(heightMeters: 206, category: .munro, name: "Sandrascal Counterhue", runningNumber: 2227),
    Munro(heightMeters: 111.2, category: .munro, name: "Jolly Ratchet", runningNumber: 2228),
]

let someRandosBelow2000: Set<Munro> = [
    Munro(heightMeters: 1165, category: .munro, name: "Stob Binnein", runningNumber: 6),
    Munro(heightMeters: 1045.9, category: .munro, name: "Cruach Ardrain", runningNumber: 11),
    Munro(heightMeters: 567.2, category: .top, name: "Botch the Grand", runningNumber: 2225),
    Munro(heightMeters: 206, category: .munro, name: "Sandrascal Counterhue", runningNumber: 2227),
    Munro(heightMeters: 111.2, category: .munro, name: "Jolly Ratchet", runningNumber: 2228),
]

let someRandosAlphabetical: [Munro] = [
    Munro(heightMeters: 567.2, category: .top, name: "Botch the Grand", runningNumber: 2225),
    Munro(heightMeters: 1045.9, category: .munro, name: "Cruach Ardrain", runningNumber: 11),
    Munro(heightMeters: 111.2, category: .munro, name: "Jolly Ratchet", runningNumber: 2228),
    Munro(heightMeters: 3876, category: .top, name: "Probably too tall", runningNumber: 2226),
    Munro(heightMeters: 206, category: .munro, name: "Sandrascal Counterhue", runningNumber: 2227),
    Munro(heightMeters: 1165, category: .munro, name: "Stob Binnein", runningNumber: 6),
]

let someRandosHeightDecending: [Munro] = [
    Munro(heightMeters: 3876, category: .top, name: "Probably too tall", runningNumber: 2226),
    Munro(heightMeters: 1165, category: .munro, name: "Stob Binnein", runningNumber: 6),
    Munro(heightMeters: 1045.9, category: .munro, name: "Cruach Ardrain", runningNumber: 11),
    Munro(heightMeters: 567.2, category: .top, name: "Botch the Grand", runningNumber: 2225),
    Munro(heightMeters: 206, category: .munro, name: "Sandrascal Counterhue", runningNumber: 2227),
    Munro(heightMeters: 111.2, category: .munro, name: "Jolly Ratchet", runningNumber: 2228),
]
