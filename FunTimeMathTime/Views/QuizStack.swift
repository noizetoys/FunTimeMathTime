//
//  QuizStack.swift
//  FunTimeMathTime
//
//  Created by Apple User on 7/3/23.
//

import SwiftUI


struct QuizStack: View {
    @State private var paths: [ProblemSetConfiguration] = []
    
    
    var body: some View {
        NavigationStack(path: $paths) {
            ProblemsConfigView(paths: $paths)
                .navigationDestination(for: ProblemSetConfiguration.self) { config in
                    QuizView(config: config)
                }
                .navigationDestination(for: HistoricalProbSet.self) { probSet in
                    HistoryDetailView(problemSet: probSet)
                }
        }
    }
    
}


//#Preview {
//    QuizStack()
//}
