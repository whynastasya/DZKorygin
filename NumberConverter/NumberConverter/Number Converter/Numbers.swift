//
//  Numbers.swift
//  NumberConverter
//
//  Created by nastasya on 21.09.2023.
//

import Foundation

final class Numbers {
    static let zero = 0
    static let units = Array(1...9)
    static let tens = Array(11...19)
    static let roundTens = Array(1...9).map { $0 * 10 }
    static let hundred = "hundred"
    static let and = "and"
    
    static func createNumbersDictionary() -> Dictionary<String, Int> {
        var numbers = [zero]
        units.map { numbers.append($0) }
        tens.map { numbers.append($0) }
        roundTens.map { numbers.append($0) }

        var numberString = Dictionary(uniqueKeysWithValues: numbers.map { ($0.string, $0) })
        numberString["hundred"] = 100
        numberString["and"] = 0
        return numberString
    }
}

let numbers = Numbers.createNumbersDictionary()

