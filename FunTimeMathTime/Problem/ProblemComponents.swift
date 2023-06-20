//
//  ProblemComponents.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI
import Foundation


enum EquationType: CaseIterable {
    case addition
    case subtraction
    case multiplication
    case division
    
    var sign: Image {
        switch self {
            case .addition: Image(systemName: "plus")
            case .subtraction: Image(systemName: "minus")
            case .multiplication: Image(systemName: "multiply")
            case .division: Image(systemName: "divide")
        }
    }
    
    
        // MARK: - Public -
    
    func solution(from equation: Equation) -> Solution {
        solution(topValue: equation.topValue, bottomValue: equation.bottomValue)
    }
    
    
    func solution(topValue: Int, bottomValue: Int) -> Solution {
        switch self {
            case .addition: return Solution(result: topValue + bottomValue, type: self)
            case .subtraction: return Solution(result: topValue - bottomValue, type: self)
            case .multiplication: return Solution(result: topValue * bottomValue, type: self)
            case .division:
                let mantissa = Int(topValue / bottomValue)
                let remainder = Int(topValue % bottomValue)
                return Solution(result: mantissa, remainder: remainder, type: self)
        }
    }
    
}


struct Solution: Identifiable, Equatable {
    let id = UUID()
    
    let result: Int
    let remainder: Int?
    let equationType: EquationType
    
    init(result: Int, remainder: Int? = nil, type: EquationType) {
        self.result = result
        self.remainder = remainder
        self.equationType = type
    }
}


class Equation: Identifiable, Hashable, Equatable {
        //class Equation: Hashable, Equatable {
        //    var id: UUID
    let id = UUID()
    
    let topValue: Int
    let bottomValue: Int
    let equationType: EquationType
    
    let solution: Solution
    
    private(set) var selectedSolution: Solution?
    var choseCorrectSolution: Bool { solution == selectedSolution }
    
    private var remainderText: String {
        guard
            let remainder = solution.remainder,
            remainder > 0
        else {
            return ""
        }
        
        return remainder > 0 ? "Remainder \(remainder)" : ""
    }
    
    var choices: [Solution]  {
        var tempOptions = [Solution]()
        
        tempOptions.append(solution)
        tempOptions.append(equationType.solution(topValue: topValue, bottomValue: bottomValue + 1))
        tempOptions.append(equationType.solution(topValue: topValue, bottomValue: bottomValue - 1))
        
            //        tempOptions.append(equationType.solution(topValue: topValue, bottomValue: bottomValue.inverted()))
        
        return tempOptions.shuffled().shuffled()
    }
    
    
        // MARK: - Lifecycle
    
    init(topValue: Int, bottomValue: Int, equationType: EquationType) {
        self.topValue = topValue
        self.bottomValue = bottomValue
        self.equationType = equationType
        
        solution = equationType.solution(topValue: topValue, bottomValue: bottomValue)
    }
    
    
        // Protocol
    static func == (lhs: Equation, rhs: Equation) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}


    // MARK: - Extension -

extension Int {
    func inverted() -> Int {
        let tens = self >= 10 ? self / 10 : 0
        let singles = self - (tens * 10)
        print("\(self): \(tens) - \(singles) or \(self) -> \((singles * 10) + tens)")
        
        return (singles * 10) + tens
    }
}
