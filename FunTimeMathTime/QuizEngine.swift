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
    var quizReady: Bool = false
    var quizInProgress = false

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

    
    init() {
//        print("\nQuizEngine: INIT problemSetConfig = \(problemSetConfig)")
    }
    
    
        // MARK: - Public -
    
    private var doneCallback: (() -> Void)? = nil
    
    func setDoneCallback(_ callback: @escaping () -> Void) {
        doneCallback = callback
    }
    
    
    func newQuiz(using config: ProblemSetConfiguration) {
        problemSetConfig = config
        
        answeredProblems = []
        unansweredProblems = []
        problems = []
        
        problems = ProblemGenerator.problemSet(for: config)
    }

    func start() {
        answeredProblems = []
        unansweredProblems = []
        unansweredProblems = problems
        quizReady = true

        next()
    }
    
    
    func end() {
        endTime = .now
        
        cancellables.forEach { $0.cancel() }
        cancellables = []
        
        doneCallback?()
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
    
    
    func saveProblemSet(to context: ModelContext) {
        // Save to Historical Data
//        print("\n🔥 QuizEngine:  saveProblemSet \nSaving \(problemSet)")
//        
//        let historical = HistoricalProbSet(problemSet: self.problemSet, config: self.problemSetConfig)
//        context.insert(object: historical)
        
    }
    
}
