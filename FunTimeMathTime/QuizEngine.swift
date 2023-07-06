//
//  QuizEngine.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/30/23.
//

import Foundation
import SwiftData
import Combine
import Observation


@Observable
class QuizEngine {
    var problemSetConfig: ProblemSetConfiguration = ProblemSetConfiguration()
    var problems: [QuizProblem] = []
    var startTime: Date = .now
    var endTime: Date = .now
    
    // For QuizView updates
    var quizInProgress = false
    var quizComplete = false

    var problemTypeString: String { problemSetConfig.problemType.rawValue }
    var problemCount: Int { problems.count }
    var correctlyAnswered: Int { problems.reduce(into: 0) { $0 = $0 + ($1.correctlyAnswered == true ? 1 : 0) } }

    var currentProblem: QuizProblem? = nil
    
    var unansweredCount: Int { unansweredProblems.count }
    var unansweredProblems: [QuizProblem] = []
    
    var answeredCount: Int { answeredProblems.count }
    private var answeredProblems: [QuizProblem] = []
    
    var timeLimit: TimeInterval { TimeInterval(problemSetConfig.timeLimit) }
    
    var questionsCountString: String {
        "\(answeredProblems.count)/\(problemCount)"
    }
    
    private var cancellables = [AnyCancellable]()
    private var problemCountCancellable = [AnyCancellable]()

    
    var context: ModelContext? = nil
    
    init(config: ProblemSetConfiguration) {
        self.context = context
        problemSetConfig = config
        problems = ProblemGenerator.problemSet(for: config)
        print("\n🚗 QuizEngine: INIT problemSetConfig = \(problemSetConfig)")
    }
    
    
        // MARK: - Public -
    
    func start() {
        answeredProblems = []
        unansweredProblems = []
        unansweredProblems = problems
        startTime = .now
        quizInProgress = true

        next()
    }
    
    
    func cancel() {
        cancellables = []
        quizInProgress = false
    }
    
    
    func end() {
        endTime = .now
        
        saveProblemSet()
        
        cancellables.forEach { $0.cancel() }
        cancellables = []
        
        quizInProgress = false
        quizComplete = true
    }
    
    
    func next() {
        cancellables.forEach { $0.cancel() }
        
        if unansweredProblems.isEmpty {
            end()
        }
        else {
            currentProblem = unansweredProblems.removeFirst()
            
            currentProblem?
                .$selectedSolution
                .sink { solution in
                    if solution == nil { return }
                    
                    if let problem = self.currentProblem {
                        self.answeredProblems.append(problem)
                        
                        if self.unansweredProblems.isEmpty == false {
                            self.next()
                        }
                        else { self.end() }
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    
    func skip() {
        guard let currentProblem
        else { return }
        
        unansweredProblems.append(currentProblem)
        next()
    }
    
    
    func saveProblemSet() {
        context?.insert(object: historicalProblemSet())
    }
    
    
    func historicalProblemSet() -> HistoricalProbSet {
        var convertedProblems = [HistoricalProblem]()
        
        for problem in problems {
            let histProb = HistoricalProblem(id: problem.id,
                                             topValue: problem.topValue,
                                             bottomValue: problem.bottomValue,
                                             problemType: problem.problemType,
                                             correctSolution: problem.correctSolution,
                                             selectedSolution: problem.selectedSolution)
            convertedProblems.append(histProb)
        }
        
        return HistoricalProbSet(problems: convertedProblems,
                                 start: startTime,
                                 end: endTime,
                                 config: problemSetConfig)
    }
}
