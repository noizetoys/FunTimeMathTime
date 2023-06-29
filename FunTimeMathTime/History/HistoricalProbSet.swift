//
//  HistoricalProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/23/23.
//

import Foundation
//import SwiftData


//@Model
class HistoricalProbSet: BasicProblemSet {
//    @Attribute(.uniue) var id: UUID
    var id: UUID
    var configuration: ProblemSetConfiguration
    private(set) var problems: [HistoricalProblem]
    
    
    let startTime: Date
    var endTime: Date
    
    var completionTime: TimeInterval
    var completionTimeString: String { completionTime.minutesSeconds }
    
    
        // MARK: - Lifecycle -
    
    init(problemSet: ProblemSet, config: ProblemSetConfiguration) {
        self.configuration = config
        self.id = UUID()
    
        self.problems = problemSet.problems.map { HistoricalProblem.new(from: $0) }
        self.startTime = problemSet.startTime
        self.endTime = problemSet.endTime
        self.completionTime = problemSet.completionTime
    }
    
    
        // MARK: - Static  -
    
    static func sampleSet(for problem: HistoricalProblem, count: Int = 20) -> HistoricalProbSet {
        let config = ProblemSetConfiguration.sampleConfig(from: problem, count: count)
        let problemSet = ProblemSet(config: config)
        problemSet.configForTesting()
        
        return .init(problemSet: problemSet, config: config)
    }
    
    
    static func sampleSet(for problem: QuizProblem, count: Int = 20) -> HistoricalProbSet {
        let config = ProblemSetConfiguration.sampleConfig(from: problem, count: count)
        let problemSet = ProblemSet(config: config)
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

