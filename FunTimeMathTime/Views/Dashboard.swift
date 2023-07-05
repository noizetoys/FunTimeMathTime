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
            
            HistoryListView()
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

    }
    
}


//#Preview {
//    Dashboard()
//}
