//
//  HistoricalProbSetConfiguration.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/30/23.
//

import Foundation
import SwiftData


//@Model
class HistoricalProbSetConfiguration: Identifiable {
//    @Attribute(.unique) private(set) var id: UUID = UUID()
    var id: UUID = UUID()
    
    var problemCount: Float = 30
    var timeLimit: Float = 3
    
    var valueRange: ClosedRange<Int> = 1...12
    var selectedValues: [Int] = []
    var autoStartQuiz: Bool = false
    
    var problemType: ProblemType = .addition
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
