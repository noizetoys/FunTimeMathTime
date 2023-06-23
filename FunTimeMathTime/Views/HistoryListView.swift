//
//  HistoryListView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/22/23.
//

import SwiftUI

struct HistoryListView: View {
    @State private var history: [HistoryProblemSet] = []
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct HistoryProblemSet: Identifiable {
    let id: UUID
    
    private var problemSet: ProblemSet
    let problems: [HistoricalProblem]
    var timeStamp: Date
    var completionTime: TimeInterval
    
    
    private var config: ProblemSetConfiguration
    let problemType: ProblemType
    let problemCount: Int
    let timeLimit: Float
    let valueRange: ClosedRange<Int>
    let selectedValues: [Int]
    
//    var totalCount: Int { problems.count }
//    var answeredCount: Int { problems.reduce(into: 0) { $0 += $1.selectedSolution == nil ? 0 : 1 } }
//    var unansweredCount: Int { problems.count - answeredCount }
//    var correctlyAnswered: Int { problems.reduce(0) { $0 + ($1.correctSolutionChosen ? 1 : 0) } }

}


struct HistoricalProblem: Identifiable, Codable {
    let id: UUID
    
    let topValue: Int
    let bottomValue: Int
    let problemType: ProblemType
    
    let correctSolution: Solution
    let selectedSolution: Solution
}


#Preview {
    
    HistoryListView()
}
