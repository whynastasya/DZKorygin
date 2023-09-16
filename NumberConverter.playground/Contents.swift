import Foundation

enum NumberType {
    case units, roundTens, tens, hundred, zero
    case and
    case error
}

extension Int {
    var string: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        let string = numberFormatter.string(from: self as NSNumber) ?? String(describing: self)
        return string
    }
}

extension String {
    var numberType: NumberType {
        let zero = 0.string
        let units = [1, 2, 3, 4, 5, 6, 7, 8, 9].map { $0.string }
        let tens = [11, 12, 13, 14, 15, 16, 17, 18, 19].map { $0.string }
        let roundTens = [10, 20, 30, 40, 50, 60, 70, 80, 90].map { $0.string }
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

let zero = 0
let units = (1...9)
let tens = (11...19)
let roundTens = (1...9).map { $0 * 10 }
let hundred = "hundred"
let and = "and"

var numbers = [zero]
units.map { numbers.append($0)}
tens.map { numbers.append($0)}
roundTens.map { numbers.append($0)}

var numberString = Dictionary(uniqueKeysWithValues: numbers.map { ($0.string, $0) })
numberString["hundred"] = 100
numberString["and"] = 0
numberString

var string = "two  hundred and"
string = string.lowercased()

var splitString = string.split(separator: " ").map( { String($0) } )
var typeString = splitString.map( { $0.numberType} )

if splitString.count > 1 && typeString.contains(where: { $0 == NumberType.zero }) {
    print("ошибочка 0")
}

if splitString.contains(where: { $0.numberType == NumberType.error }) {
    print("лишнее слово/цифра")
}

if splitString.count == 1 && splitString[0].numberType != .hundred && splitString[0].numberType != .and {
    print("конверт числа")
}

if splitString[splitString.count - 1].numberType == .and {
    print("and последний надо единицу")
}

//var result = splitString.reduce("") { (number, nextNumber) in
//    let numberType = number.numberType
//    print(numberType)
//    let nextNumberType = nextNumber.numberType
////    print(nextNumberType)
//    switch numberType {
//        case .units:
//            if nextNumberType != .hundred {
//                print(1)
//                return "после единиц могут следовать только сотни"
//            }
//        case .tens:
//            return "после 11, 12 ничего не следует"
//        case .roundTens:
//            if nextNumberType != .units {
//                return "после круглых десятков идут только единицы"
//            }
//        case .hundred:
//            if nextNumberType == .units {
//                return "между единицами надо добавить and"
//            } else if nextNumberType == .hundred {
//                return "после сотен можно писать десятки и единицы"
//            }
//        case .and:
//            if nextNumberType != .units {
//                return "лишнее слово and"
//            }
//        case .error:
//            return nextNumber
//        default:
//            number + nextNumber
//    }
//    return "error"
//}

//print(result)

func checkConditions(splitString: [String]) -> String {
    let typeString = splitString.map { $0.numberType }
    
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
    return "true"
}

print(checkConditions(splitString: ["one", "hundred", "and"]))
//if typeString.count == 1 {
//    if typeString[0] == .units || typeString[0] == .tens || typeString[0] == .roundTens || typeString[0] == .zero {
//
//    }
//} else {

func convert(splitString: [String]) -> Int {
    var result = 0

    if splitString.count > 2 || splitString.contains(where: {$0 == "hundred" }) {
        result = numberString[splitString[0]]! * numberString[splitString[1]]!
        for i in 2..<splitString.count {
            result += numberString[splitString[i]]!
        }
        return result
    }

    for i in 0..<splitString.count {
        result += numberString[splitString[i]] ?? 1000
    }
    return result
}

convert(splitString: splitString)
