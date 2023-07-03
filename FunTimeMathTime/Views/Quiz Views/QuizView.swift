//
//  QuizView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI
import SwiftData
import Combine


struct QuizView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(QuizEngine.self) private var quizEngine: QuizEngine
    @Environment(\.modelContext) private var context
    
    @State private var showCountdownSheet = false
    @State private var showQuizCompleteSheet = false
    
    @State private var timer: Timer? = nil

    @State var remainingSeconds: TimeInterval = 0
    var timeString: String {
        let minutes = Int(remainingSeconds / 60)
        let seconds = Int(remainingSeconds.truncatingRemainder(dividingBy: 60))
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(minutes):\(secondsString)"
    }

    
        // MARK: - Private -
    
    
        // MARK: - LifeCycle -

    init() {
     print("QuizView: init called.....")
    }
    
    
    var body: some View {
        VStack(spacing: 40) {
            timerView
            
            HStack {
                ScrollView(.horizontal) {
                    
                    HStack {
                        if quizEngine.quizInProgress {
                            ProblemView(problem: quizEngine.currentProblem)
                        }
                        else {
                            tapToBeginButton
                        }
                    }
                }
                .frame(width: 450, height: 350)
                
            }
            
            HStack {
                Spacer()
                
                if quizEngine.quizInProgress {
                    endButton
                    Spacer()
                    skipButton
                    Button("Show") {
                        showQuizCompleteSheet = true
                    }
                }
                else {
                    cancelButton
                }
                
                Spacer()
                
            }
        }
        .safeAreaPadding(.horizontal)
        .sheet(isPresented: $showCountdownSheet, onDismiss: {
            startTimer()
            withAnimation {
                quizEngine.quizInProgress = true
            }
            self.quizEngine.setDoneCallback {
                self.showQuizCompleteSheet.toggle()
            }
            quizEngine.start()
        }, content: {
            CountDownSheet()
        })
        .sheet(isPresented: $showQuizCompleteSheet) {
            withAnimation {
                quizEngine.saveProblemSet(to: context)
                quizEngine.end()
                quizEngine.quizReady = false
            }
        } content: {
            QuizCompleteView()
                .clipShape(RoundedRectangle(cornerRadius: 35))
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
            remainingSeconds = 0
            
        }
    }
    
    
        // MARK: - Custom Views -
    
    private var tapToBeginButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 10.0)
                }
                .padding(5)
            
            
            Text("Tap to Begin")
                .font(.largeTitle)
                .bold()
        }
        .frame(width: 450)
        .onTapGesture {
            withAnimation {
                showCountdownSheet = true
            }
        }
    }
    
    
    private func startTimer() {
        if quizEngine.timeLimit > 0 {
            remainingSeconds = quizEngine.timeLimit * 60.0
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.remainingSeconds -= 1
                
                if self.remainingSeconds <= 0 {
                    self.quizEngine.end()
                    self.showQuizCompleteSheet.toggle()
                }
            }
            timer?.fire()
        }
    }
    
    private var timerView: some View {
        HStack {
            Spacer()
            
            Text("\(timeString)")
                .font(.system(size: 96, weight: .bold, design: .none))
                .foregroundStyle(quizEngine.quizInProgress ? .black : .gray.opacity(0.3))
            
            Spacer()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            Text("\(quizEngine.questionsCountString)")
                .font(.system(size: 96, weight: .bold, design: .none))

            Spacer()
        }
        .fixedSize()
    }
    
    
    private var skipButton: some View {
        Button(action: {
            print("Skip Buttom Pressed")
            withAnimation {
                quizEngine.skip()
            }
        }, label: {
            Text("Skip")
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

    
    private var endButton: some View {
        Button(action: {
            showQuizCompleteSheet = true
        }, label: {
            Text("End")
                .foregroundStyle(Color.black)
                .font(.title)
                .bold()
                .padding()
        })
        .buttonBorderShape(.roundedRectangle)
        .frame(width: 200)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 6)
        }
    }
    
    
    private var cancelButton: some View {
        Button(role: .cancel) {
            withAnimation {
                quizEngine.end()
                dismiss()
            }
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
    
}


#Preview {
//    QuizView(config: ProblemSetConfiguration(problemType: .addition,
//                                             problemCount: 30,
//                                             timeLimit: 3,
////                                             timeLimit: 0.05,
//                                             valueRange: 2...12,
//                                             selectedValues: [3, 7, 9],
//                                             randomize: true))
    QuizView()
}
