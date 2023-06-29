//
//  HistoryDetailView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/27/23.
//

import SwiftUI


struct HistoryDetailView: View {
    let problemSet: HistoricalProbSet
    
    
    var rows: [GridItem] {
        var theRows = [GridItem]()
        
        for _ in 1...8 {
            let item = GridItem(.flexible(), alignment: .center)
            theRows.append(item)
        }
        
        return theRows
    }
    

    init(problemSet: HistoricalProbSet) {
        self.problemSet = problemSet
    }
    
    
    var body: some View {
        ScrollView(.vertical) {
            headerView
            
            LazyVGrid(columns: rows) {
                ForEach(problemSet.problems) { problem in
                    HistoricalProblemView(problem: problem)
                        .padding()
                }
            }
        }
    
    }
    
    
    private var headerView: some View {
        HStack {
            Text("\(problemSet.problemCount) \(problemSet.problemType.rawValue) Problems,")
            Text("\(problemSet.answeredCount) Answered,")
            Text("\(problemSet.correctlyAnswered) Correct,")
            Text("Completed in \(problemSet.completionTimeString)")
        }
        .font(.title)
        .bold()
    }
    
}


#Preview {
    let randomTop = Int.random(in: 2...12)
    let randomBottom = Int.random(in: 2...12)
    let randomType = ProblemType.allCases.randomElement()!
    let problemCount = [20, 30, 40, 50].randomElement()!
    
    let problem = HistoricalProblem.sampleProblem(top: randomTop, bottom: randomBottom, type: randomType)
    
    return HistoryDetailView(problemSet: HistoricalProbSet.sampleSet(for: problem, count: problemCount))
}
