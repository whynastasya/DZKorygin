//
//  NumberConverter.swift
//  NumberConverter
//
//  Created by nastasya on 23.09.2023.
//

import Foundation

final class NumberConverter {
    static func createSplitString(numberString: String) -> [String] {
        let splitString = numberString.lowercased().split(separator: " ").map( { String($0) } )
        return splitString
    }
    
    static func convert(splitString: [String]) -> Int {
        var result = 0

        if splitString.count > 2 || splitString.contains(where: {$0 == "hundred" }) {
            result = numbers[splitString[0]]! * numbers[splitString[1]]!
            for i in 2..<splitString.count {
                result += numbers[splitString[i]]!
            }
            return result
        }

        for i in 0..<splitString.count {
            result += numbers[splitString[i]] ?? 1000
        }
        return result
    }
    
    static func checkConditions(numberString: String) -> String {
        let splitString = createSplitString(numberString: numberString)
        let result = String(convert(splitString: splitString))
        let typeString = splitString.map { $0.numberType }
        
        if numberString.isEmpty {
            return("fl;sfsd")
        }
        
        if typeString.count > 1 && typeString.contains(where: { $0 == NumberStringType.zero }) {
            return "ошибочка 0"
        }

        if typeString.contains(where: { $0 == NumberStringType.error }) {
            return "лишнее слово/цифра"
        }

        if typeString.count == 1 && typeString[0] != .hundred && typeString[0] != .and {
            return  result
        }

        if typeString[typeString.count - 1] == .and {
            return "and последний надо единицу"
        }
        
        for i in 0...typeString.count - 2 {
            switch typeString[i] {
                case .units:
                    if typeString[i + 1] != .hundred {
                        return "после единиц могут следовать только сотни"
                    }
                case .tens:
                    return "после 11, 12 ничего не следует"
                case .roundTens:
                    if typeString[i + 1] != .units {
                        return "после круглых десятков идут только единицы"
                    }
                case .hundred:
                    if typeString[i + 1] == .units {
                        return "между единицами надо добавить and"
                    } else if typeString[i + 1] == .hundred {
                        return "после сотен можно писать десятки и единицы"
                    }
                case .and:
                    if typeString[i + 1] != .units {
                        return "лишнее слово and"
                    }
                default:
                    return "error"
            }
        }
        return result
    }
}
