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

        if splitString.count > 2 || splitString.contains(where: { $0 == "hundred" }) {
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
    
    static func checkConditions(numberString: String) -> Result {
        let splitString = createSplitString(numberString: numberString)
        let typeString = splitString.map { $0.numberType }
        
        if numberString.isEmpty {
            return Result(result: "Для начала введите число😊", type: .error)
        }
        
        if typeString.contains(where: { $0 == NumberStringType.error }) {
            for i in 0..<typeString.count {
                if typeString[i] == .error {
                    return Result(result: "Неправильное написание числа: - \(splitString[i])😢", type: .error)
                }
            }
        }
        
        if typeString.count > 1 && typeString.contains(where: { $0 == NumberStringType.zero }) {
            return Result(result: "Лишний ноль🫣", type: .error)
        }

        if typeString.count == 1 && typeString[0] != .hundred && typeString[0] != .and {
            return Result(result: String(convert(splitString: splitString)), type: .result)
        }

        if typeString[typeString.count - 1] == .and {
            return Result(result: "Лишнее слово 'and'🥱", type: .error)
        }
        
        for i in 0...typeString.count - 2 {
            switch typeString[i] {
                case .units:
                    if typeString[i + 1] == .hundred && i != 0 {
                        return Result(result: "Нарушен порядок образования единиц (1, 2...9)🤧", type: .error)
                    }
                case .tens:
                    return Result(result: "Нарушен порядок образования чисел формата 11, 12...19🫤", type: .error)
                case .roundTens:
                    if typeString[i + 1] != .units  {
                        return Result(result: "Нарушен порядок образования десяток (10, 20...90)🤥", type: .error)
                    }
                case .hundred:
                    if typeString[i + 1] == .units {
                        return Result(result: "Между сотней и единицей надо добавить 'and'🤒", type: .error)
                    } else if typeString[i + 1] == .hundred {
                        return Result(result: "Нарушен порядок образования сотен (100, 200...900)👹", type: .error)
                    }
                case .and:
                    if typeString[i + 1] != .units {
                        return Result(result: "Лишнее слово 'and'🥱", type: .error)
                    }
                default:
                    return Result(result: "error", type: .error)
            }
        }
        return Result(result: String(convert(splitString: splitString)), type: .result)
    }
}
