//
//  QuizProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/20/23.
//


import SwiftUI


class QuizProblemSet: ProblemSet {
    var id: UUID = UUID()
    
//    var showCountdownSheet: Bool = false
    
    // Kept clean to save
    private(set) var problems: [QuizProblem] = []
    
    var configuration: ProblemSetConfiguration
    var startTime: Date = .now
    var endTime: Date = .now
    
   
        // MARK: - Lifecycle -
    
    init(config: ProblemSetConfiguration) {
        id = UUID()
        
        configuration = config
        problems = ProblemGenerator.problemSet(for: config)
    }
    
    
        // MARK: - Public -

//    func showCountdown() {
//        showCountdownSheet = true
//    }
    
}


extension QuizProblemSet: CustomStringConvertible {
    var description: String {
        """
        problemType: \(problemType.rawValue)
        valueRange: \(valueRange)
        selectedValues: \(selectedValues)
        selectedValues: \(selectedValues)
        
        problemCount: \(problemCount)
        """
    }
    
}


extension QuizProblemSet {
    
    func configForTesting() {
//        let endTime = Date.now
//        let startTime = endTime.addingTimeInterval(-(3 * 60))
        let halfOfProblems = Int(problemCount / 2)
        
        for index in 0...(halfOfProblems) {
            let problem = problems[index]
            problem.selectedSolution = problem.correctSolution
        }
        
        for index in halfOfProblems...(problemCount - 1) {
            let problem = problems[index]
            problem.selectedSolution = problem.solutions.first { $0 != problem.correctSolution }
        }
    }
}


