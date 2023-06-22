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
    var unansweredCount: Int { problems.count - answeredCount }
    var completionTime: TimeInterval = 0
    
    var answeredCount: Int {
        problems.reduce(into: 0) { number, problem in
            number += problem.selectedSolution == nil ? 0 : 1
        }
    }
    
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
                    print("ProblemSet: selectedSolution == \(solution)")
                    self.objectWillChange.send()
                }
                .store(in: &cancellables)
        }
    }
    
    
    func startTimer() {
        
    }
    
    
    func stopTimer() {
        
    }
    
    
}
