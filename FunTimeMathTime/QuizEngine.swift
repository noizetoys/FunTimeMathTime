//
//  QuizEngine.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/30/23.
//

import Foundation
import Observation


@Observable
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
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let url = paths.first?.appendingPathComponent("previousQuizes.qzz", conformingTo: .utf8PlainText)
        else { return }
        
        let encoder = JSONEncoder()
        let setToSave = HistoricalProbSet(problemSet: problemSet, config: problemSetConfig)
        do {
            let data = try encoder.encode(setToSave)
            try data.write(to: url)
            print("Data \(data) written")
        }
        catch {
            print("Error Saving Problem Set: \(error)")
        }
    }
    
}
