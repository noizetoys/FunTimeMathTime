//
//  Problem.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI
import Foundation


class Problem: Identifiable {
    let id = UUID()
    var index: Int = 0
    
    let topValue: Int
    let bottomValue: Int
    let problemType: ProblemType
    
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
    
    var choices: [Solution] = []
    
    
        // MARK: - Lifecycle
    
    init(topValue: Int, bottomValue: Int, problemType: ProblemType) {
        self.topValue = topValue
        self.bottomValue = bottomValue
        self.problemType = problemType
        
        solution = problemType.solution(topValue: topValue, bottomValue: bottomValue)
        
        var tempOptions = [Solution]()
        
        tempOptions.append(solution)
        tempOptions.append(problemType.solution(topValue: topValue, bottomValue: bottomValue + 1))
        tempOptions.append(problemType.solution(topValue: topValue, bottomValue: bottomValue - 1))
        
            //        tempOptions.append(ProblemType.solution(topValue: topValue, bottomValue: bottomValue.inverted()))
        
        choices = tempOptions.shuffled().shuffled()
    }
    
    
    func duplicate() -> Problem {
        Problem(topValue: topValue, bottomValue: bottomValue, problemType: problemType)
    }
    
}
    
extension Problem: Equatable, Hashable {
        // Protocol
    static func == (lhs: Problem, rhs: Problem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}


extension Problem: CustomStringConvertible {
    var description: String {
        "\n\(topValue) \(problemType) \(bottomValue) = \(solution.result) (\(solution.remainder ?? 0))"
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
