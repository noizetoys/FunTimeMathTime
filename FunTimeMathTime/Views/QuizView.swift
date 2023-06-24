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
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerRunning: Bool = false
    @State private var remainingSeconds: Int = 0
    
    @State private var canAnswerQuestions: Bool = true
    
    @State private var showCountdownSheet = false
    @State private var countdownSheetAlreadyShown = false
    @State private var showQuizCompleteSheet = false
    
    
    private let config: ProblemSetConfiguration
    
    private var needsTimer: Bool { config.timeLimit > 0 }
    private var timeString: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(minutes):\(secondsString)"
    }

    
        // MARK: - LifeCycle -

    init(config: ProblemSetConfiguration) {
        self.config = config

        _problemSet = StateObject(wrappedValue: ProblemSet(config: config))
    }
    
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 40) {
                timerView
                
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
                    cancelButton
                    
                    Spacer()
                        .frame(width: 55)
                    
                    startButton
                    Spacer()
                }
                .fixedSize()
            }
            .environmentObject(problemSet)
            .safeAreaPadding(.horizontal)
            .onAppear {
                self.timerRunning = false
                    //            if countdownSheetAlreadyShown == false {
                    //                showCountdownSheet = true
                    //            }
                timer.connect().cancel()
            }
            .allowsHitTesting(canAnswerQuestions)
            .sheet(isPresented: $showCountdownSheet, onDismiss: {
                countdownSheetAlreadyShown = true
                timer.connect().cancel()
                canAnswerQuestions = false
                timerRunning = true
                start()
            }, content: {
                CountDownSheet()
            })
            .sheet(isPresented: $showQuizCompleteSheet) {
                dismiss()
            } content: {
                QuizCompleteView(problemSet: problemSet)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
            }
            
            Spacer()
        }
        
    }
    
    
        // MARK: - Custom Views -
    
    private var timerView: some View {
        HStack {
            Spacer()
            
            Text("\(timeString)")
                .font(.system(size: 96, weight: .bold, design: .none))
                .foregroundStyle(timerRunning ? .black : .gray.opacity(0.3))
                .onReceive(timer) { _ in
                    self.remainingSeconds -= 1
                    if remainingSeconds <= 0 {
                        end()
                    }
                }
            
            Spacer()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            Text("\(problemSet.totalCount - problemSet.answeredCount)")
                .font(.system(size: 96, weight: .bold, design: .none))

            Spacer()
        }
        .fixedSize()
    }
    
    
    private var startButton: some View {
        Button(action: {
            print("startButton: Start/End Button Pressed")
            timerRunning.toggle()
            print("startButton: timerRunning = \(timerRunning)")
            timerRunning ? start() : end()
        }, label: {
            Text(timerRunning ? "End" : "Start")
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
    }
    
    
    private var cancelButton: some View {
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
    }
    
    
        // MARK: - Private Methods -

    private func start() {
        print("Start Called")
        
        if countdownSheetAlreadyShown  {
//            if let timeLimit = config.timeLimit, timeLimit > 0 {
            if config.timeLimit > 0 {
                remainingSeconds = Int(config.timeLimit * 60.0)
                timer = Timer.publish(every: 1, on: .main, in: .common)
                _ = timer.connect()
            }
            canAnswerQuestions = true
        }
        else {
            showCountdownSheet = true
        }
    }
    
    
    private func end() {
        print("End called")
        timer.connect().cancel()
        timerRunning = false
        canAnswerQuestions = false
        
        problemSet.endTime = .now
        
        showQuizCompleteSheet = true
        // End timer
        // Show Alert
        // Save Data for History
        // Dismiss View back to Dahboard
    }
    
}


#Preview {
    QuizView(config: ProblemSetConfiguration(problemType: .addition,
                                             problemCount: 30,
//                                             timeLimit: 3,
                                             timeLimit: 0.05,
                                             valueRange: 2...12,
                                             selectedValues: [3, 7, 9],
                                             randomize: true))
}
