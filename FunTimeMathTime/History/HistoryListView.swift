//
//  HistoryListView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/22/23.
//

import SwiftUI
import SwiftData


struct HistoryListView: View {
    @State private var problemSets: [HistoricalProbSet]
//    @Environment(\.modelContext) private var modelContext
//    @Query var problemSets: [HistoricalProbSet]
    
    
    init(problemSets: [HistoricalProbSet]) {
        _problemSets = State(initialValue: problemSets)
//        self.problemSets = problemSets
    }
    
    
    var body: some View {
            VStack {
                
                List {
                    Section {
                        ForEach(problemSets) { set in
                            NavigationLink {
                            } label: {
                                HistoryListCellView(problemSet: set)
                            }

                        }
                    } header: {
                        Text("Previous Quizes")
                    }
                    
                }
        }
    }
}


struct HistoryListCellView: View {
    var problemSet: HistoricalProbSet
    
    
    init(problemSet: HistoricalProbSet) {
        self.problemSet = problemSet
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(problemSet.answeredCount)/\(problemSet.problemCount)")
                    .bold()
                
                Text("\(problemSet.problemType.rawValue)")
                    .italic()
                    .bold()
                
                
                Text("- \(problemSet.selectedValuesString)")
                
                Spacer()
            }
            
            HStack {
                Text("\(problemSet.dateString)")
            }
        }
        
    }
    
    
    var dataView: some View {
        VStack(alignment: .leading) {
            Text("TimeStamp: \(problemSet.dateString)")
            Text("Completion time: \(problemSet.completionTime)")
            Text("Time Limit: \(problemSet.timeLimit)")
            Text("Value Range: \(problemSet.valueRange.lowerBound)...\(problemSet.valueRange.upperBound)")
            Text("Count: \(problemSet.problemCount)")
            Text("Problem Type: \(problemSet.problemType.rawValue)")
            Text("Correct: \(problemSet.correctlyAnswered)")
            Text("Unanswered: \(problemSet.unansweredCount)")
            
            VStack(alignment: .leading) {
                ForEach(problemSet.selectedValues, id: \.self) { value in
                    Text("Selected Value: \(value)")
                }
            }
            
            problemsView
        }
    }
    
    
    var problemsView: some View {
        ForEach(problemSet.problems) { problem in
            HStack {
                HStack {
                    Text("\(problem.topValue)")
                    problem.problemType.sign
                    Text("\(problem.bottomValue)")
                }
                .frame(width: 80)
                
                Spacer()
                    .frame(width: 20)
                
                HStack {
                    if problem.correctSolutionChosen {
                        Text("Solution: \(problem.correctSolution.result)")
                            .foregroundStyle(.green)
                            .bold()
                    }
                    else {
                        if let selected = problem.selectedSolution {
                                //                    Text("Chosen: \(problem.selectedSolution?.result), Correct: \(problem.correctSolution.result)")
                            Text("Chosen: \(selected.result)")
                            Spacer()
                                .frame(width: 20)
                            Text("Correct: \(problem.correctSolution.result)")
                        }
                        else {
                            Text("No Solution Chosen!")
                        }
                    }
                }
                
                Spacer()
                
            }
        }

    }
}



#Preview {
//    let sampleSet = HistoricalProbSet.sampleHistoricalSet()
//    let aProblem = Problem(topValue: 7, bottomValue: 8, problemType: .addition)
//    let sample = HistoricalProbSet.sampleHistoricalSet()
    
//    return HistoryListView(problemSets: [sampleSet])
    HistoryListView(problemSets: [
        HistoricalProbSet.sampleHistoricalSet(),
        HistoricalProbSet.sampleHistoricalSet(),
        HistoricalProbSet.sampleHistoricalSet(),
        HistoricalProbSet.sampleHistoricalSet(),
        HistoricalProbSet.sampleHistoricalSet()
    ])
}
