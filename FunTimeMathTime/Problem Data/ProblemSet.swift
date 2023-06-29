//
//  ProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/20/23.
//

//import Foundation
import SwiftUI
import Combine


class ProblemSet: BasicProblemSet, ObservableObject {
    @Published var problems: [QuizProblem] = []
    
    var id: UUID
    var configuration: ProblemSetConfiguration
    
    var startTime: Date = .now
    var endTime: Date = .now
    
    private var cancellables = [AnyCancellable]()
    
   
        // MARK: - Lifecycle -
    
    init(config: ProblemSetConfiguration) {
        id = UUID()
        
        configuration = config
        problems = ProblemGenerator.problemSet(for: config)
        
        problems.forEach { problem in 
            problem
                .$selectedSolution
                .sink { solution in
                    if solution == nil { return }
                    self.objectWillChange.send()
                }
                .store(in: &cancellables)
        }
    }
    
}


extension ProblemSet {
    
    func configForTesting() {
        let endTime = Date.now
        let startTime = endTime.addingTimeInterval(-(3 * 60))
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


