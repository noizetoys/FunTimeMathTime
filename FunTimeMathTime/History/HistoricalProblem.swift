//
//  HistoricalProblem.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/23/23.
//

import Foundation
import SwiftData


@Model
class HistoricalProblem: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var topValue: Int
    var bottomValue: Int
    var problemType: String
    
    var selectedSolution: Solution?
    var correctSolution: Solution
    
    var correctSolutionChosen: Bool { selectedSolution == correctSolution }
    
    
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
        self.problemType = problemType.rawValue
        self.correctSolution = correctSolution
        self.selectedSolution = selectedSolution
    }
    
    
    static func new(from problem: QuizProblem) -> HistoricalProblem {
        HistoricalProblem.init(id: problem.id,
                               topValue: problem.topValue,
                               bottomValue: problem.bottomValue,
                               problemType: problem.problemType,
                               correctSolution: problem.correctSolution,
                               selectedSolution: problem.selectedSolution)
    }
    
    
//    static func sampleProblem(top: Int?, bottom: Int?, type: ProblemType? = .addition) -> HistoricalProblem {
//        let topValue = top ?? Int.random(in: 2...12)
//        let bottomValue = bottom ?? Int.random(in: 2...12)
//        let problemType = type ?? ProblemType.allCases.randomElement() ?? .addition
//        let correctSolution = problemType.solution(from: QuizProblem(topValue: topValue, bottomValue: bottomValue, problemType: problemType))
//        let incorrectSolution = problemType.solution(from: QuizProblem(topValue: topValue, bottomValue: bottomValue + 1, problemType: problemType))
//        
//        let possibileSolutions: [Solution?] = [correctSolution, incorrectSolution, nil]
//        var selected: Solution? { possibileSolutions.randomElement() ?? nil }
//        
//        return HistoricalProblem(id: UUID(),
//                          topValue: topValue,
//                          bottomValue: bottomValue,
//                          problemType: problemType,
//                          correctSolution: correctSolution,
//                          selectedSolution: selected)
//    }
//    
//    
//    static func sampleProblems(_ count: Int, top: Int?, type: ProblemType? = .addition) -> [HistoricalProblem] {
//        var problems = [HistoricalProblem]()
//        let topValue = top ?? Int.random(in: 2...12)
//        let type = type ?? ProblemType.allCases.randomElement() ?? .addition
//        
//        for _ in 0..<count {
//            problems.append(.sampleProblem(top: topValue, bottom: Int.random(in: 2...12), type: type))
//        }
//        
//        return problems
//    }
    
}

//extension HistoricalProblem: CustomStringConvertible {
//    var description: String {
//        "Historical Problem: \(topValue) \(problemType) \(bottomValue) = \(correctSolution) --> Selected \(String(describing: selectedSolution))"
//    }
//}
