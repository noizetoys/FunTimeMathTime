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
    @Published var selectedSolution: Solution?

    
    var solutions: [Solution] = []
    
    private var remainderText: String {
        guard
            let remainder = correctSolution.remainder,
            remainder > 0
        else {
            return ""
        }
        
        return "Remainder \(remainder)"
    }
    
    // Used for animation
    var index: Int = 0
    
    
        // MARK: - Lifecycle
    
    init(topValue: Int, bottomValue: Int, problemType: ProblemType) {
        id = UUID()
        
        self.topValue = topValue
        self.bottomValue = bottomValue
        self.problemType = problemType
        
        correctSolution = problemType.solution(topValue: topValue, bottomValue: bottomValue)
        
        var tempOptions = [Solution]()
        
        tempOptions.append(correctSolution)
        tempOptions.append(problemType.solution(topValue: topValue, bottomValue: bottomValue + 1))
        tempOptions.append(problemType.solution(topValue: topValue, bottomValue: bottomValue - 1))
        
        solutions = tempOptions.shuffled().shuffled()
    }
    
    
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
        "\(topValue) \(problemType) \(bottomValue) = \(correctSolution) --> Selected \(selectedSolution)"
    }
}


extension QuizProblem {
    static func sampleProblem(top: Int = 7, type: ProblemType = .addition) -> QuizProblem {
        let bottomValue = Int.random(in: 2...12)
        let sample = QuizProblem(topValue: top, bottomValue: bottomValue, problemType: type)
        let correctSolution = sample.correctSolution
        let incorrectSolution = sample.solutions.first(where: { $0.id != correctSolution.id })
        
        var possibileSolutions: [Solution?] = [correctSolution, incorrectSolution, nil]
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


    // MARK: - Extension -

extension Int {
    func inverted() -> Int {
        let tens = self >= 10 ? self / 10 : 0
        let singles = self - (tens * 10)
        print("\(self): \(tens) - \(singles) or \(self) -> \((singles * 10) + tens)")
        
        return (singles * 10) + tens
    }
}
