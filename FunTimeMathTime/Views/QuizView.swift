//
//  QuizView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI


struct QuizView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(QuizEngine.self) private var quizEngine: QuizEngine

    @State private var showCountdownSheet = false
    @State private var quizInProgress = false
    @State private var quizComplete = false
    
    
        // MARK: - Private -
    
    private var needsTimer: Bool { quizEngine.problemSetConfig.timeLimit > 0 }
    
    
        // MARK: - LifeCycle -

//    init() { }
    
    
    var body: some View {
        VStack(spacing: 40) {
            timerView
            
            HStack {
                ScrollView(.horizontal) {
                    
                    HStack {
                        if quizInProgress {
                            ProblemView(problem: quizEngine.problemSet.currentProblem)
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
                
                if quizInProgress {
                    endButton
                    Spacer()
                    skipButton
                }
                else {
                    cancelButton
                }
                
                Spacer()
                
            }
            .safeAreaPadding(.horizontal)
            .sheet(isPresented: $showCountdownSheet, onDismiss: {
                withAnimation {
                    quizInProgress = true
                }
                quizEngine.problemSet.start()
            }, content: {
                CountDownSheet()
            })
            .sheet(isPresented: $quizComplete) {
                withAnimation {
                    quizInProgress = false
                }
                dismiss()
            } content: {
                QuizCompleteView()
                    .clipShape(RoundedRectangle(cornerRadius: 35))
            }
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
    
    
    private var timerView: some View {
        HStack {
            Spacer()
            
            Text("\(quizEngine.problemSet.timeString)")
                .font(.system(size: 96, weight: .bold, design: .none))
                .foregroundStyle(quizInProgress ? .black : .gray.opacity(0.3))
            
            Spacer()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            Text("\(quizEngine.problemSet.questionsCountString)")
                .font(.system(size: 96, weight: .bold, design: .none))

            Spacer()
        }
        .fixedSize()
    }
    
    
    private var skipButton: some View {
        Button(action: {
            print("Skip Buttom Pressed")
            withAnimation {
                quizEngine.problemSet.skip()
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
            withAnimation {
                quizComplete = true
                quizEngine.problemSet.end()
                quizEngine.saveProblemSet()
            }
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
