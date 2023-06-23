//
//  ProblemSetConfiguration.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import Foundation


class ProblemSetConfiguration: ObservableObject, Identifiable {
    private(set) var id = UUID()
    
    @Published var problemCount: Float
    @Published var timeLimit: Float
    
    @Published var valueRange: ClosedRange<Int>
    @Published var selectedValues: [Int]
    var problemType: ProblemType
    var randomize: Bool
    
   
        // MARK: - Lifecycle -

    init(problemType: ProblemType = .addition,
         problemCount: Float = 30,
         timeLimit: Float = 3,
         valueRange: ClosedRange<Int> = 1...12,
         selectedValues: [Int] = [],
         randomize: Bool = true)
    {
        self.problemType = problemType
        self.problemCount = problemCount
        self.timeLimit = timeLimit
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


extension ProblemSetConfiguration: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
        randomize: \(randomize)
        """
    }
    
    
}
