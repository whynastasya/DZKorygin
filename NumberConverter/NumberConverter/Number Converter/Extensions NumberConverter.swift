//
//  Extensions .swift
//  NumberConverter
//
//  Created by nastasya on 21.09.2023.
//

import Foundation

extension Int {
    var string: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        let string = numberFormatter.string(from: self as NSNumber) ?? String(describing: self)
        return string
    }
}

extension String {
    var numberType: NumberStringType {
        let zero = 0.string
        let units = (1...9).map { $0.string }
        let tens = (11...19).map { $0.string }
        let roundTens = (1...9).map { $0 * 10 }.map { $0.string }
        let hundred = "hundred"
        let and = "and"
        if units.contains(where: { $0 == self }) {
            return .units
        } else if tens.contains(where:  { $0 == self }) {
            return .tens
        } else if roundTens.contains(where:  { $0 == self }) {
            return .roundTens
        } else if hundred == self {
            return .hundred
        } else if zero == self {
            return .zero
        } else if and == self {
            return .and
        } else {
            return .error
        }
    }
}
