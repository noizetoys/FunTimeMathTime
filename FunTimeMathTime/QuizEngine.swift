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

    init(config: ProblemSetConfiguration) {
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
    
    
    func end() {
        endTime = .now
        
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
    
    
    func saveProblemSet(to context: ModelContext) {
        // Save to Historical Data
        print("\n🔥 QuizEngine:  saveProblemSet")
        var convertedProblems = [HistoricalProblem]()
//
        for problem in problems {
            let histProb = HistoricalProblem(id: problem.id,
                                             topValue: problem.topValue,
                                             bottomValue: problem.bottomValue,
                                             problemType: problem.problemType,
                                             correctSolution: problem.correctSolution,
                                             selectedSolution: problem.selectedSolution)
            convertedProblems.append(histProb)
        }
            //        let problemSet = HistoricalProbSet(problems: problems, start: startTime, end: endTime, config: problemSetConfig)
        
//        print("\n🔥 QuizEngine:  saveProblemSet: problemSet = \(problemSet)")
        print("\n🔥 QuizEngine:  saveProblemSet: convertedProblems")
        for problem in convertedProblems {
            print(problem)
        }
//        print("\n🔥 QuizEngine:  saveProblemSet: convertedProblems = \(convertedProblems)")
//        context.insert(object: problemSet)
        
    }
    
}
