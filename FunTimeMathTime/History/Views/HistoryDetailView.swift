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
        
        for _ in 1...6 {
            let item = GridItem(.flexible(), alignment: .center)
            theRows.append(item)
        }
        
        return theRows
    }
    

    init(problemSet: HistoricalProbSet) {
        self.problemSet = problemSet
    }
    
    
    var body: some View {
        VStack {
            headerView
            
            ScrollView(.vertical) {
                LazyVGrid(columns: rows) {
                    ForEach(problemSet.problems) { problem in
                        HistoricalProblemView(problem: problem)
                            .padding(10)
                    }
                }
            }
        }
        .padding()
    
    }
    
    
    private var headerView: some View {
        HStack {
//            Text("\(problemSet.problemCount) \(problemSet.problemType.rawValue) Problems,")
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
