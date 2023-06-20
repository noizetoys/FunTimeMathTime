//
//  ProblemSetConfiguration.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import Foundation


class ProblemSetConfiguration: Identifiable {
    private(set) var id = UUID()
    
    var problemType: ProblemType
    var problemCount: Int
    
    var timeLimit: Int?
    
    var valueRange: ClosedRange<Int>
    var selectedValues: [Int]
    var randomize: Bool
    
    
    init(problemType: ProblemType,
         problemCount: Int,
         timeLimit: Int? = nil,
         valueRange: ClosedRange<Int>,
         selectedValues: [Int],
         randomize: Bool = true)
    {
        self.problemType = problemType
        self.problemCount = problemCount
        self.timeLimit = timeLimit ?? nil
        self.valueRange = valueRange
        self.selectedValues = selectedValues
        self.randomize = randomize
    }
    
}


extension ProblemSetConfiguration: Equatable {
    static func == (lhs: ProblemSetConfiguration, rhs: ProblemSetConfiguration) -> Bool {
        lhs.id == rhs.id
    }
}


extension ProblemSetConfiguration: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        ProblemSetConfiguration:
        type: \(problemType)
        count: \(problemCount)
        timeLimit: \(timeLimit ?? 0)
        range: \(valueRange)
        values: \(selectedValues)
        randomize: \(randomize)
        """
    }
    
    
}
