//
//  BasicProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/27/23.
//

import Foundation


protocol BasicProblemSet: Identifiable {
    associatedtype Problem: BasicProblem
    
    var id: UUID { get }
    var configuration: ProblemSetConfiguration { get }
    var problems: [Problem] { get }
    var startTime: Date { get }
    var endTime: Date { get set }
}


extension BasicProblemSet {
    // Configuration related
    var problemType: ProblemType { configuration.problemType }
    var timeLimit: Float { configuration.timeLimit }
    var valueRange: ClosedRange<Int> { configuration.valueRange }
    var selectedValues: [Int] { configuration.selectedValues }
    
    // Problem Set Related
    var problemCount: Int { problems.count }
    var answeredCount: Int { problems.reduce(into: 0) { $0 += $1.selectedSolution == nil ? 0 : 1 } }
    var unansweredCount: Int { problems.count - answeredCount }
    var correctlyAnswered: Int { problems.reduce(0) { $0 + ($1.correctSolutionChosen ? 1 : 0) } }
    
    var dateString: String { timeStamp.formatted(date: .numeric, time: .omitted) }
    var selectedValuesString: String { selectedValues.map( { "\($0)" }).joined(separator: ", ")  }
    
    var timeStamp: Date { endTime }
    var completionTime: TimeInterval { endTime.timeIntervalSince(startTime) }

}


