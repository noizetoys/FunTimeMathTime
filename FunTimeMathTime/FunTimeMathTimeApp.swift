//
//  FunTimeMathTimeApp.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI


@main
struct FunTimeMathTimeApp: App {
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            QuizView(config: ProblemSetConfiguration(problemType: .addition,
                                                     problemCount: 30,
                                                     timeLimit: 3,
                                                     valueRange: 2...12,
                                                     selectedValues: [3, 7, 9],
                                                     randomize: true))

        }
    }
    
}
