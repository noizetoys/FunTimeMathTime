//
//  QuizEngine.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/30/23.
//

import Foundation
import Observation


@Observable
//class QuizEngine: ObservableObject {
class QuizEngine {
    var problemSetConfig: ProblemSetConfiguration = ProblemSetConfiguration()
    var problemSet: QuizProblemSet = QuizProblemSet(config: ProblemSetConfiguration())
    
    init() { }
    
    
        // MARK: - Public -

    @discardableResult
    func newProblemSetConfig() -> ProblemSetConfiguration {
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

    
    func saveProblemSet() {
        // Save to Historical Data
        print("\n\n🔥 QuizEngine:  saveProblemSet \nSaving \(problemSet)")
    }
}
