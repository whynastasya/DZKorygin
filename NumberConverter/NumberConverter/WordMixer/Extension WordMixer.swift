//
//  Extensions.swift
//  NumberConverter
//
//  Created by nastasya on 26.09.2023.
//

import Foundation

extension String {
    func slice(startIndex: Int, endIndex: Int) -> Result {
        if self.isEmpty {
            return Result(result: "Для начала введите предложение😊", type: .error)
        }
        
        if startIndex == -18943 || endIndex == 18943 {
            return Result(result: "Введите все необходимые числа больше 0😢", type: .error)
        }
        
        if startIndex == 0 || endIndex == 0 {
            return Result(result: "Числа должны быть больше 0🤥", type: .error)
        }
        var splitString = self.split(separator: " ").map({ String($0) })
        
        if startIndex > splitString.count || endIndex > splitString.count {
            return Result(result: "Число превышает количество слов в предложении🫤", type: .error)
        }

        if endIndex < startIndex {
            return Result(result: "Второе число должно быть больше первого🫣", type: .error)
        }
        
        var result = " "
        for i in startIndex-1..<endIndex {
            result += splitString[i] + " "
        }
        
        for _ in startIndex-1..<endIndex {
            splitString.remove(at: startIndex - 1)
        }
        
        return Result(result: splitString.joined(separator: " ") + result, type: .result)
    }
}
