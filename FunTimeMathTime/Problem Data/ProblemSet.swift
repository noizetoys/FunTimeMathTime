//
//  ProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/20/23.
//

//import Foundation
import SwiftUI
import Combine


class ProblemSet: ObservableObject {
    @Published var problems: [Problem] = []
    
    private let config: ProblemSetConfiguration
    
    var totalCount: Int { problems.count }
    var answeredCount: Int { problems.reduce(into: 0) { $0 += $1.selectedSolution == nil ? 0 : 1 } }
    var unansweredCount: Int { problems.count - answeredCount }
    var correctlyAnswered: Int { problems.reduce(0) { $0 + ($1.correctSolutionChosen ? 1 : 0) } }

    // For saving in Document
    var startTime: Date = .now
    var endTime: Date = .now
    
    var completionTime: TimeInterval { endTime.timeIntervalSince(startTime) }
    
    private var cancellables = [AnyCancellable]()
   
        // MARK: - Lifecycle -
    
    init(config: ProblemSetConfiguration) {
        self.config = config
        
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
        let halfOfProblems = totalCount / 2
        
        for index in 0...(halfOfProblems) {
            let problem = problems[index]
            problem.selectedSolution = problem.correctSolution
        }
        
        for index in halfOfProblems...(totalCount - 1) {
            let problem = problems[index]
            problem.selectedSolution = problem.solutions.first { $0 != problem.correctSolution }
        }
    }
}


