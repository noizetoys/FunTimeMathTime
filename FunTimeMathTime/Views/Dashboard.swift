//
//  Dashboard.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI

struct Dashboard: View {
    @StateObject var problemSetConfig: ProblemSetConfiguration = ProblemSetConfiguration()
    
    var body: some View {
//        NavigationStack {
            
            GeometryReader { geo in
                HStack {
                    
                    VStack {
                        List {
                            Section {
                                ForEach(1...20, id:\.self) { num in
                                    HStack {
                                        Text("Quiz \(num)")
                                        Spacer()
                                    }
                                }
                            } header: {
                                Text("Previous Quizes")
                            } footer: {
                                    //                            EmptyView()
                            }
                            
                        }
                    }
                    .frame(maxWidth: geo.size.width / 4.0)
                    
                    ProblemTypePickerView()
//                        .navigationDestination(for: ProblemSetConfiguration.self) { config in
//                            QuizView(config: config)
//                        }
                } // H
                
            } // Geo
            .padding()
            .environmentObject(problemSetConfig)
//        } // Nav
        
    }
    
}


#Preview {
    Dashboard()
}
