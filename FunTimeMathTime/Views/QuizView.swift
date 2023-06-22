//
//  QuizView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI


struct QuizView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var problemSet: ProblemSet
    
    @State private var timer: Timer?
    @State private var remainingSeconds: Int = 0 {
        didSet { print("RemainingSeconds: \(remainingSeconds)")}
    }
    @State private var hasStarted: Bool = false
    @State private var hasEnded: Bool = false
    
    private let config: ProblemSetConfiguration
    
    private var needsTimer: Bool { config.timeLimit != nil }
    private var timeString: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(minutes):\(secondsString)"
    }

    // Temp
    private var unsolved: Int { problemSet.problems.reduce(0) { partialResult, prob in
        partialResult + (prob.selectedSolution == nil ? 1 : 0)
    }}
    
    private var solved: Int { problemSet.problems.reduce(0) { partialResult, prob in
        partialResult + (prob.selectedSolution != nil ? 1 : 0)
    }}
    
    
    private var correctlyAnswered: Int { problemSet.problems.reduce(0) { partialResult, prob in
        partialResult + (prob.correctSolutionChosen ? 1 : 0)
    }}
    
    
        // MARK: - LifeCycle -

    init(config: ProblemSetConfiguration) {
        self.config = config

        _problemSet = StateObject(wrappedValue: ProblemSet(config: config))
    }
    
    
    private func configTimer() {
        
    }
    
   
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Text("\(timeString) Remaining")
                    .foregroundStyle(hasStarted ? .black : .gray.opacity(0.3))
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            
            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(problemSet.problems) { problem in
                        if problem.selectedSolution == nil {
                            ProblemView(problem: problem)
                        }
                    }
                }
            }
            .frame(width: 450, height: 350)
                
            HStack {
                Spacer()
                
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .padding()
                }
                .buttonBorderShape(.roundedRectangle)
                .frame(width: 200)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 6)
                }
                
                Spacer()
                
                Button(action: {
                    hasStarted.toggle()
                    hasStarted ? end() : start()
                }, label: {
                    Text(hasStarted ? "End" : "Start")
                        .foregroundStyle(Color.black)
                        .font(.title)
                        .bold()
                        .padding()
                })
                .buttonBorderShape(.roundedRectangle)
                .frame(width: 200)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 6)
                }
                
                Spacer()
            }
            .padding()
            
            
            VStack {
                Text("Problem Count: \(problemSet.problems.count)")
                Text("Unsolved Problem Count: \(unsolved)")
                Text("Solved Problem Count: \(solved)")
            }
            .font(.title)
            
        }
        .environmentObject(problemSet)
        .safeAreaPadding(.horizontal)
    }
    
    
    private func start() {
        if let timeLimit = config.timeLimit, timeLimit > 0 {
            remainingSeconds = timeLimit * 60
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                if remainingSeconds == 0 {
                    end()
                }
                else {
                    remainingSeconds -= 1
                }
            })
            timer?.fire()
            
        }
            
        // Tell Problem Set time remains
        
    }
    
    
    private func end() {
        timer?.invalidate()
        timer = nil
        // End timer
        // Tell Problem Set time is up
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
