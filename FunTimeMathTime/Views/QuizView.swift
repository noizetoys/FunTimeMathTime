//
//  QuizView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI


struct QuizView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var problemSet: [Problem]
    @State private var currentProblem: Problem?
    
    @State private var remainingSeconds: Int
    @State private var hasStarted: Bool = true //false
    @State private var hasEnded: Bool = true // false
    
    private let config: ProblemSetConfiguration
    
    private var needsTimer: Bool = false
    
    private var remainingProblemCount: Int {
        let workedProblems = problemSet.filter( { $0.selectedSolution != nil })
        return problemSet.count - workedProblems.count
    }
    
    private let dateFormatter: DateFormatter
    
    
        // MARK: - LifeCycle -

    init(config: ProblemSetConfiguration) {
        print("Quizview: config: \(config)")
        self.config = config
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M:s"

        let generatedProblems = ProblemGenerator.problemSet(for: config)
        print("QuizView:  generated count == \(generatedProblems.count)")
        _problemSet = .init(initialValue: generatedProblems)
        
        if let timeLimit = config.timeLimit, timeLimit > 0 {
            _remainingSeconds = .init(initialValue: timeLimit * 60)
            needsTimer = true
        }
        else {
            _remainingSeconds = .init(initialValue: 0)
        }

        print("QuizView:  ProblemSet count == \(problemSet.count)")
    }
    
   
    var body: some View {
        VStack {
//            Spacer()
            
            if hasStarted {
                HStack {
                    if needsTimer {
                        Spacer()
                        Text("Time Remaining")
                    }
                    
                    Spacer()
                    
                    Text("\(remainingProblemCount) Problems Remaining")
                    Spacer()
                }
                .font(.title)
                .bold()
            }
            
            QuizProblemSetView(config: config)
            
            HStack {
                Spacer()
                
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button("Start") {
                    
                }
                
                Spacer()
            }
            
        }
        .safeAreaPadding(.horizontal)
            //        .padding()
//        .border(.blue)
    }
    
    
    private func start() {
        
    }
    
    
    private var problemSetView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(problemSet) { problem in
                    ProblemView(problem: problem)
                        .scrollTarget()
                        .padding()
                        .border(.red)
                }
            }
            .scrollTargetLayout()
            
            Spacer()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .frame(maxHeight: 250)
        .padding()
        .border(.red)
    }
    
}


#Preview {
    QuizView(config: ProblemSetConfiguration(problemType: .addition,
                                             problemCount: 30,
                                             timeLimit: 3,
                                             valueRange: 2...12,
                                             selectedValues: [3, 7, 9],
                                             randomize: true))
}
