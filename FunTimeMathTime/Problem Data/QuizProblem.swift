//
//  QuizProblem.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI
import Combine

// TODO: Add way to store for future reference

class QuizProblem: BasicProblem, ObservableObject {
    let id: UUID
    
    let topValue: Int
    let bottomValue: Int
    let problemType: ProblemType
    
    let correctSolution: Solution
        // Used to trigger changing problem
    @Published var selectedSolution: Solution?
        /// Not published.
        ///  Used to overcome problem with last question
        ///  Triggering 'SINK' before actual assignment occurs
    var solutionSelected: Solution?
    
    var correctlyAnswered: Bool? {
        guard let selected = selectedSolution
        else { return nil}
        
        return selected == correctSolution
    }
    
    var solutions: [Solution] = []
    
    private var remainderText: String {
        guard
            correctSolution.containsRemainder
        else {
            return ""
        }
        
        return "Remainder \(correctSolution.remainder)"
    }
    
        // Used for animation
    var index: Int = 0
    
    @AppStorage(SettingsConstants.RANDOMIZEPROBLEMS) private var randomizeProblems: Bool = true

        // MARK: - Lifecycle
    
    init(topValue: Int, bottomValue: Int, problemType: ProblemType) {
        id = UUID()
        
        self.topValue = topValue
        self.bottomValue = bottomValue
        self.problemType = problemType
        
        correctSolution = problemType.solution(topValue: topValue, bottomValue: bottomValue)
        
        createSolutions()
    }
    
    
    private func createSolutions() {
        var tempOptions = [Solution]()
        
        tempOptions.append(correctSolution)
        
        if problemType == .division && topValue < bottomValue {
            tempOptions.append(problemType.solution(topValue: topValue, bottomValue: topValue - 1))
            tempOptions.append(problemType.solution(topValue: topValue, bottomValue: topValue + 1))
        }
        else {
            tempOptions.append(problemType.solution(topValue: topValue, bottomValue: bottomValue + 1))
            tempOptions.append(problemType.solution(topValue: topValue, bottomValue: bottomValue - 1))
        }
        
        if randomizeProblems {
            for _ in 1...Int.random(in: 3...10) {
                tempOptions.shuffle()
            }
        }
        
        solutions = tempOptions
    }
    
   
        // MARK: - Public -
    
 func duplicate() -> QuizProblem {
        QuizProblem(topValue: topValue, bottomValue: bottomValue, problemType: problemType)
    }
    
}

    
extension QuizProblem: Equatable, Hashable {
    static func == (lhs: QuizProblem, rhs: QuizProblem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


extension QuizProblem: CustomStringConvertible {
    var description: String {
        "QuizProblem: \(topValue) \(problemType) \(bottomValue) = \(correctSolution) --> Selected \(String(describing: selectedSolution))"
    }
}


extension QuizProblem {
    static func sampleProblem(top: Int = 7, type: ProblemType = .addition) -> QuizProblem {
        let bottomValue = Int.random(in: 2...12)
        let sample = QuizProblem(topValue: top, bottomValue: bottomValue, problemType: type)
        let correctSolution = sample.correctSolution
        let incorrectSolution = sample.solutions.first(where: { $0.id != correctSolution.id })
        
        let possibileSolutions: [Solution?] = [correctSolution, incorrectSolution, nil]
        var selected: Solution? { possibileSolutions.randomElement() ?? nil }

        sample.selectedSolution = selected
        
        return sample
    }
    
    
    static func sampleProblems(top: Int = 7, type: ProblemType = .addition, count: Int = 20) -> [QuizProblem] {
        var problems = [QuizProblem]()
        
        for _ in 1...20 {
            problems.append(sampleProblem(top: top, type: type))
        }
        
        return problems
    }
}


