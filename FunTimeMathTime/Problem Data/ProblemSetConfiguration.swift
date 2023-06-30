//
//  ProblemSetConfiguration.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import Foundation
import Observation


@Observable
class ProblemSetConfiguration: Identifiable {
    private(set) var id: UUID = UUID()
    
    var problemType: ProblemType = .addition
    var problemCount: Float = 30
    var timeLimit: Float = 3
    
    var valueRange: ClosedRange<Int> = 1...12
    var selectedValues: [Int] = []
    var autoStartQuiz: Bool = false
    
    var randomize: Bool = true
    
   
        // MARK: - Lifecycle -

    init(problemType: ProblemType = .addition,
         problemCount: Float = 30,
         timeLimit: Float = 3,
         valueRange: ClosedRange<Int> = 1...12,
         selectedValues: [Int] = [],
         autoStart: Bool = true,
         randomize: Bool = true)
    {
        self.problemType = problemType
        self.problemCount = problemCount
        self.timeLimit = timeLimit
        self.valueRange = valueRange
        self.selectedValues = selectedValues
        self.autoStartQuiz = autoStart
        self.randomize = randomize
    
        id = UUID()
    }
    
}


extension ProblemSetConfiguration: Equatable {
    static func == (lhs: ProblemSetConfiguration, rhs: ProblemSetConfiguration) -> Bool {
        lhs.id == rhs.id
    }
}


extension ProblemSetConfiguration: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


extension ProblemSetConfiguration {
    static func sampleConfig(from problem: HistoricalProblem, count: Int = 20) -> ProblemSetConfiguration {
        sampleConfig(top: problem.topValue, type: problem.problemType, count: count)
    }
    
    
    static func sampleConfig(from problem: QuizProblem, count: Int = 20) -> ProblemSetConfiguration {
        sampleConfig(top: problem.topValue, type: problem.problemType, count: count)
    }
    
    
    static func sampleConfig(top: Int = 7, type: ProblemType = .addition, count: Int = 20) -> ProblemSetConfiguration {
        ProblemSetConfiguration(problemType: type,
                                problemCount: Float(count),
                                timeLimit: 3.0,
                                valueRange: 2...12,
                                selectedValues: [top],
                                autoStart: true,
                                randomize: true)
    }
    
}


extension ProblemSetConfiguration: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        ProblemSetConfiguration:
        type: \(problemType)
        count: \(problemCount)
        timeLimit: \(timeLimit)
        range: \(valueRange)
        values: \(selectedValues)
        autoStart: \(autoStartQuiz)
        randomize: \(randomize)
        """
    }
    
    
}
