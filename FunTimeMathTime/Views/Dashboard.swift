//
//  Dashboard.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI
import SwiftData


struct Dashboard: View {
    var body: some View {
        
        TabView {
            QuizStack()
                .tabItem {
                    Image(systemName: "plus.forwardslash.minus")
                    Text("Quiz")
                }
            
            Text("History")
                .tabItem {
                    Image(systemName: "list.number")
                    Text("History")
                }
            
            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
//        NavigationSplitView {
//                
//                List(selection: $selectedRow) {
//                    NavigationLink {
//                        ProblemsConfigView()
//                    } label: {
//                        Text("New Quiz")
//                    }
//
//                    ForEach(problemSets) { set in
//                        NavigationLink {
//                            HistoryDetailView(problemSet: set)
//                        } label: {
//                            HistoryListCellView(problemSet: set)
//                        }
//                    }
//                    
//                }
//
//        } detail: {
//            if quizEngine.quizReady {
//                QuizView()
//            }
//            else if selectedRow == nil {
//                ProblemsConfigView()
//            }
//        }
//        .onAppear {
//            selectedRow = nil
//        }

    }
    
}


//#Preview {
//    Dashboard()
//}
