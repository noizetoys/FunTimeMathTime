//
//  FunTimeMathTimeApp.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI
import SwiftData


@main
struct FunTimeMathTimeApp: App {

    var body: some Scene {
        WindowGroup {
            Dashboard()
                .modelContainer(for: [HistoricalProbSet.self, HistoricalProblem.self, Solution.self])
//                .modelContainer(for: [HistoricalProbSet.self, QuizProblem.self, Solution.self])

        }
    }
    
}

//extension EnvironmentValues {
//    var library: Library {
//        get { self[LibraryKey.self] }
//        set { self[LibraryKey.self] = newValue }
//    }
//}
//
//
//private struct LibraryKey: EnvironmentKey {
//    static var defaultValue: Library = Library()
//}
