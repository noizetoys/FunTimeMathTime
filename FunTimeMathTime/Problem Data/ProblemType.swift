//
//  ProblemType.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI


enum ProblemType: String, CaseIterable, Codable {
    case addition = "Addition"
    case subtraction = "Subtraction"
    case multiplication = "Multiplication"
    case division = "Division"
    
    var sign: Image {
        switch self {
            case .addition: Image(systemName: "plus")
            case .subtraction: Image(systemName: "minus")
            case .multiplication: Image(systemName: "multiply")
            case .division: Image(systemName: "divide")
        }
    }
    
    
        // MARK: - Public -
    
    func solution(from equation: Problem) -> Solution {
        solution(topValue: equation.topValue, bottomValue: equation.bottomValue)
    }
    
    
    func solution(topValue: Int, bottomValue: Int) -> Solution {
        switch self {
            case .addition: return Solution(result: topValue + bottomValue)
            case .subtraction: return Solution(result: topValue - bottomValue)
            case .multiplication: return Solution(result: topValue * bottomValue)
            case .division:
                let mantissa = Int(topValue / bottomValue)
                let remainder = Int(topValue % bottomValue)
                return Solution(result: mantissa, remainder: remainder)
        }
    }
    
}


