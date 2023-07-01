//
//  HistoricalProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/23/23.
//

import Foundation
//import SwiftData


//@Model
//class HistoricalProbSet: ProblemSet, Identifiable  {
    
class HistoricalProbSet: Identifiable, Codable {
//    @Attribute(.unique) var id: UUID
    var id: UUID
//    private(set) var problems: [HistoricalProblem]
    var problems: [HistoricalProblem]
//    var configuration: ProblemSetConfiguration
    
    let startTime: Date
    var endTime: Date
    
    var completionTimeString: String { endTime.timeIntervalSince(startTime).minutesSeconds }
   
    // Configuration
   var problemCount: Float
   var timeLimit: Float
   
    var valueRangeLowerBounds: Int
    var valueRangeUpperBounds: Int
//   var valueRange: ClosedRange<Int>
   var selectedValues: [Int]
   var autoStartQuiz: Bool
    
    var problemType: ProblemType
    var randomize: Bool

    var answeredCount: Int { problems.reduce(into: 0) { $0 += $1.selectedSolution == nil ? 0 : 1 } }
    var selectedValuesString: String { selectedValues.map( { "\($0)" }).joined(separator: ", ")  }
    var correctlyAnswered: Int { problems.reduce(0) { $0 + ($1.correctSolutionChosen ? 1 : 0) } }

    
    
        // MARK: - Lifecycle -
    
    init(problemSet: QuizProblemSet, config: ProblemSetConfiguration) {
        self.id = problemSet.id
//        self.configuration = config
    
        self.problems = problemSet.problems.map { HistoricalProblem.new(from: $0) }
        self.startTime = problemSet.startTime
        self.endTime = problemSet.endTime
        
        
            // Configuration
        problemCount = config.problemCount
        timeLimit = config.timeLimit
        valueRangeLowerBounds = config.valueRange.lowerBound
        valueRangeUpperBounds = config.valueRange.upperBound
//        valueRange = config.valueRange
        selectedValues = config.selectedValues
        autoStartQuiz = config.autoStartQuiz
        problemType = config.problemType
        randomize = config.randomize
    }
    
    
        // MARK: - Static  -
    
    static func sampleSet(for problem: HistoricalProblem, count: Int = 20) -> HistoricalProbSet {
        let config = ProblemSetConfiguration.sampleConfig(from: problem, count: count)
        let problemSet = QuizProblemSet(config: config)
        problemSet.configForTesting()
        
        return .init(problemSet: problemSet, config: config)
    }
    
    
    static func sampleSet(for problem: QuizProblem, count: Int = 20) -> HistoricalProbSet {
        let config = ProblemSetConfiguration.sampleConfig(from: problem, count: count)
        let problemSet = QuizProblemSet(config: config)
        problemSet.configForTesting()
        
        return .init(problemSet: problemSet, config: config)
    }

    
    static func sampleHistoricalSet(for topValue: Int = 7, type: ProblemType = .addition) -> HistoricalProbSet {
        let sampleProblem = HistoricalProblem.new(from: QuizProblem.sampleProblem(top: topValue, type: type))
        return sampleSet(for: sampleProblem)
    }
    
}


extension TimeInterval {
    var hourMinuteSecondMS: String {
        String(format:"%d:%02d:%02d.%03d", hour, minute, second, millisecond)
    }
    
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
    
    var minutesSeconds: String {
        "\(minute > 0 ? "\(minute):" : "")\(second)\(minute < 1 ? " seconds" : "")"
    }
    
}

