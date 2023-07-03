//
//  QuizEngine.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/30/23.
//

import Foundation
import SwiftData


@Observable
class QuizEngine {
    var problemSetConfig: ProblemSetConfiguration = ProblemSetConfiguration()
    var problemSet: QuizProblemSet = QuizProblemSet(config: ProblemSetConfiguration())
    var quizReady: Bool = false
    
    
    init() {
        print("\nQuizEngine: INIT problemSetConfig = \(problemSetConfig)")
        print("\nQuizEngine: INIT problemSet = \(problemSet)")
    }
    
    
    
        // MARK: - Public -

    @discardableResult
    func newProblemSetConfig() -> ProblemSetConfiguration {
        print("\n🔥 QuizEngine:  newProblemSetConfig Called")
        problemSetConfig = ProblemSetConfiguration()
        return problemSetConfig
    }
    
    
    @discardableResult
    func newProblemSet() -> QuizProblemSet {
        problemSet = QuizProblemSet(config: problemSetConfig)
        return problemSet
    }
    
    
    @discardableResult
    func newProblemSet(from config: ProblemSetConfiguration) -> QuizProblemSet {
        problemSet = QuizProblemSet(config: config)
        return problemSet
    }

    
    func saveProblemSet(to context: ModelContext) {
        // Save to Historical Data
        print("\n🔥 QuizEngine:  saveProblemSet \nSaving \(problemSet)")
        
        let historical = HistoricalProbSet(problemSet: self.problemSet, config: self.problemSetConfig)
        context.insert(object: historical)
        
    }
    
}
