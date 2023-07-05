//
//  HistoryDetailView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/27/23.
//

import SwiftUI


struct HistoryDetailView: View {
    let problemSet: HistoricalProbSet
    
    
    var columns: [GridItem] = [
        GridItem(.fixed(120), spacing: 40),
        GridItem(.fixed(120))
    ]

    init(problemSet: HistoricalProbSet) {
        self.problemSet = problemSet
    }
    
    
    var body: some View {
        VStack {
            headerView
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(problemSet.problems) { problem in
                        HistoricalProblemView(problem: problem)
                    }
                }
            }
            
        }
        .padding()
    
    }
    
    
    private var headerView: some View {
        VStack {
            Text("\(Int(problemSet.problemCount)) \(problemSet.problemType) Problems,")
            Text("\(problemSet.answeredCount) Answered,")
            Text("\(problemSet.correctlyAnswered) Correct,")
            Text("Completed in \(problemSet.completionTimeString)")
        }
        .font(.title)
        .bold()
    }
    
}


//#Preview {
//    let randomTop = Int.random(in: 2...12)
//    let randomBottom = Int.random(in: 2...12)
////    let randomType = ProblemType.allCases.randomElement()!
//    let randomType = ProblemType.division
//    let problemCount = [20, 30, 40, 50].randomElement()!
//    
//    let problem = HistoricalProblem.sampleProblem(top: randomTop, bottom: randomBottom, type: randomType)
//    
//    return HistoryDetailView(problemSet: HistoricalProbSet.sampleSet(for: problem, count: problemCount))
//}
