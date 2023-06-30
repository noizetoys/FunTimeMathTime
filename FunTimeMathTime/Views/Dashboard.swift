//
//  Dashboard.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI

struct Dashboard: View {
    @Environment(QuizEngine.self) private var quizEngine: QuizEngine

//    @EnvironmentObject private var quizEngine: QuizEngine

    
    var body: some View {
        GeometryReader { geo in
            
            HStack {
                HistoryListView(problemSets: [HistoricalProbSet.sampleHistoricalSet()])
                    .frame(maxWidth: geo.size.width / 4)
                
                ProblemTypePickerView()
            }
            .padding()
            
        } // Geo
//        .environmentObject(quizEngine)
        
    }
    
}


#Preview {
    Dashboard()
}
