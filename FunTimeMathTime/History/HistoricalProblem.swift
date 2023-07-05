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
//    var id: UUID
    
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
    print("\n ---> Historical Problem:  INIT")
        self.id = id
    print("ID: \(id)")
        self.topValue = topValue
    print("Top Value: \(topValue)")
        self.bottomValue = bottomValue
    print("Bottom Value: \(bottomValue)")
        self.problemType = problemType.rawValue
    print("Problem Type: \(problemType)")
        self.correctSolution = correctSolution
    print("Correct Solution: \(correctSolution)")
        self.selectedSolution = selectedSolution
    print("Selected Solution: \(selectedSolution)")
    }
    
    
    static func new(from problem: QuizProblem) -> HistoricalProblem {
    print("\n ---> Historical Problem:  new from \(problem)")
        
        return HistoricalProblem.init(id: problem.id,
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
