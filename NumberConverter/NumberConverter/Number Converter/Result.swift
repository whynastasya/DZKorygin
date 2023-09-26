//
//  Result.swift
//  NumberConverter
//
//  Created by nastasya on 24.09.2023.
//

import Foundation
import SwiftUI

struct Result {
    var result: String
    var type: ResultType
}

enum ResultType {
    case error
    case result
    case `default`
    
    var color: Color {
        switch self {
        case .error:
            return .red
        case .result:
            return .green
        case .`default`:
            return .purple
        }
    }
}
