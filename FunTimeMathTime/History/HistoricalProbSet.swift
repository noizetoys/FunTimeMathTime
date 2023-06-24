//
//  HistoricalProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/23/23.
//

import Foundation
//import SwiftData


//@Model
class HistoricalProbSet: Identifiable {
//    @Attribute(.uniue) var id: UUID
    var id: UUID
    
    private(set) var problems: [HistoricalProblem]
    let timeStamp: Date
    var completionTime: TimeInterval
    
    let problemType: ProblemType
    
    let timeLimit: Float
    let valueRange: ClosedRange<Int>
    let selectedValues: [Int]
    

        // MARK: - Lifecycle -
    
    init(problemSet: ProblemSet, config: ProblemSetConfiguration) {
        self.id = UUID()
    
        self.problems = problemSet.problems.map { HistoricalProblem.new(from: $0)}
        self.timeStamp = problemSet.endTime
        self.completionTime = problemSet.completionTime
        
        self.problemType = config.problemType
        self.timeLimit = config.timeLimit
        self.valueRange = config.valueRange
        self.selectedValues = config.selectedValues
    }
    
    
    static func sampleSet(for problem: HistoricalProblem, count: Int = 20) -> HistoricalProbSet {
        let config = ProblemSetConfiguration.sampleConfig(from: problem)
        let problemSet = ProblemSet(config: config)
        problemSet.configForTesting()
        
        return .init(problemSet: problemSet, config: config)
    }
    
    
    static func sampleSet(for problem: Problem, count: Int = 20) -> HistoricalProbSet {
        let config = ProblemSetConfiguration.sampleConfig(from: problem)
        let problemSet = ProblemSet(config: config)
        problemSet.configForTesting()
        
        return .init(problemSet: problemSet, config: config)
    }

    
    static func sampleHistoricalSet(for topValue: Int = 7, type: ProblemType = .addition) -> HistoricalProbSet {
        let sampleProblem = HistoricalProblem.new(from: Problem.sampleProblem(top: topValue, type: type))
        return sampleSet(for: sampleProblem)
    }
    
}


    // MARK: - Calculated -
extension HistoricalProbSet {
    var problemCount: Int { problems.count }
    var answeredCount: Int { problems.reduce(into: 0) { $0 += $1.selectedSolution == nil ? 0 : 1 } }
    var unansweredCount: Int { problems.count - answeredCount }
    var correctlyAnswered: Int { problems.reduce(0) { $0 + ($1.correctlyAnswered ? 1 : 0) } }
    var dateString: String { timeStamp.formatted(date: .numeric, time: .omitted) }
    var selectedValuesString: String { selectedValues.map( { "\($0)" }).joined(separator: ", ")  }
}




