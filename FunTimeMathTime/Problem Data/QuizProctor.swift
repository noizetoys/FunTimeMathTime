//
//  QuizProctor.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/28/23.
//

import Foundation

// Config Related
//    @Published var problemCount: Float
//    @Published var timeLimit: Float
//
//    @Published var valueRange: ClosedRange<Int>
//    @Published var selectedValues: [Int]
//    @Published var autoStartQuiz: Bool
//
//    var problemType: ProblemType
//    var randomize: Bool


    // time
    // # of remaing problems
    // Score? right/total
    // cancel action

    // setting access
    // show answer?
    // Score?
    // ???



    // Auto-start
    // Button Start
    // Cancel Button


    // Time runs out
    // All problems answered
    // End button pressed


class QuizProctor: ObservableObject {
    private var problemSet: ProblemSet
    private let config: ProblemSetConfiguration
    
    @Published var currentProblem: QuizProblem?
//    @Published var timeString: String = ""
    @Published var remainProblemCountText: String = ""
    @Published private var remainingSeconds: Int = 0
    
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common)
    private var timerRunning: Bool = false
    
    
    private var timeString: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(minutes):\(secondsString)"
    }
    
   
        // MARK: - LifeCycle -
    
    init(config: ProblemSetConfiguration) {
        self.config = config
        problemSet = ProblemSet(config: config)
        currentProblem = problemSet.problems.first
    }
    
    
        // MARK: - Public -

    func start() {
        
    }
    
    
    func end() {
        
    }
    
    
    
}

