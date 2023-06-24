//
//  HistoricalProblem.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/23/23.
//

import Foundation
//import SwiftData


//@Model
class HistoricalProblem: Identifiable {
//    @Attribute(.unique) var id: UUID
    var id: UUID
    
    let topValue: Int
    let bottomValue: Int
    let problemType: ProblemType
    
    let correctSolution: Solution
    let selectedSolution: Solution?
    
    
        // MARK: - Calculated -
    
    var correctlyAnswered: Bool {
        guard selectedSolution != nil
        else { return false }
        
        return selectedSolution == correctSolution
    }
    
    
        // MARK: - Lifecycle  -
    
    required init(id: UUID,
                  topValue: Int,
                  bottomValue: Int,
                  problemType: ProblemType,
                  correctSolution: Solution,
                  selectedSolution: Solution?)
    {
        self.id = id
        self.topValue = topValue
        self.bottomValue = bottomValue
        self.problemType = problemType
        self.correctSolution = correctSolution
        self.selectedSolution = selectedSolution
    }
}


extension HistoricalProblem {
    static func new(from problem: Problem) -> HistoricalProblem {
        HistoricalProblem.init(id: problem.id,
                  topValue: problem.topValue,
                  bottomValue: problem.bottomValue,
                  problemType: problem.problemType,
                  correctSolution: problem.correctSolution,
                  selectedSolution: problem.selectedSolution)
    }
}


extension HistoricalProblem {
//    let total = Int.random(in: 1...10) * 10
//    private(set) var correct: Int
//    let type: ProblemType? = .allCases.randomElement()
//    let month = Int.random(in: 1...12)
//    let day = Int.random(in: 1...28)

    static func sampleProblem(top: Int?, bottom: Int?, type: ProblemType? = .addition) -> HistoricalProblem {
        let topValue = top ?? Int.random(in: 2...12)
        let bottomValue = bottom ?? Int.random(in: 2...12)
        let problemType = type ?? ProblemType.allCases.randomElement() ?? .addition
        let correctSolution = problemType.solution(from: Problem(topValue: topValue, bottomValue: bottomValue, problemType: problemType))
        let incorrectSolution = problemType.solution(from: Problem(topValue: topValue, bottomValue: bottomValue + 1, problemType: problemType))
        
        var possibileSolutions: [Solution?] = [correctSolution, incorrectSolution, nil]
        var selected: Solution? { possibileSolutions.randomElement() ?? nil }
        
        
        return HistoricalProblem(id: UUID(),
                          topValue: topValue,
                          bottomValue: bottomValue,
                          problemType: problemType,
                          correctSolution: correctSolution,
                          selectedSolution: selected)
    }
    
    static func sampleProblems(_ count: Int, top: Int?, type: ProblemType? = .addition) -> [HistoricalProblem] {
        var problems = [HistoricalProblem]()
        var topValue = top ?? Int.random(in: 2...12)
        var type = type ?? ProblemType.allCases.randomElement() ?? .addition
        
        for _ in 0..<count {
            problems.append(.sampleProblem(top: topValue, bottom: Int.random(in: 2...12), type: type))
        }
        
        return problems
    }
    
    
}
