//
//  Dashboard.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI
import SwiftData


struct Dashboard: View {
    @Environment(QuizEngine.self) private var quizEngine: QuizEngine
    @Environment(\.modelContext) private var modelContext
    @Query var problemSets: [HistoricalProbSet]

    @State private var selectedRow: HistoricalProbSet?
    
    var body: some View {
        NavigationSplitView {
                
                List(selection: $selectedRow) {
                    NavigationLink {
                        ProblemTypePickerView()
                    } label: {
                        Text("New Quiz")
                    }

                    ForEach(problemSets) { set in
                        NavigationLink {
                            HistoryDetailView(problemSet: set)
                        } label: {
                            HistoryListCellView(problemSet: set)
                        }
                    }
                    
                }

        } detail: {
            if quizEngine.quizReady {
                QuizView()
            }
            else if selectedRow == nil {
                ProblemTypePickerView()
            }
        }
        .onAppear {
            selectedRow = nil
        }

    }
    
}


#Preview {
    Dashboard()
}
