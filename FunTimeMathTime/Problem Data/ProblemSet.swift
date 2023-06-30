//
//  ProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/20/23.
//

//import Foundation
import SwiftUI
import Combine


class ProblemSet: BasicProblemSet, ObservableObject {
    @Published var currentProblem: QuizProblem?
    @Published var remainingSeconds: TimeInterval = 0
    @Published var quizComplete: Bool = false
//    @Published var quizInProgress: Bool = false
    @Published var showCountdownSheet: Bool = false
    
    var id: UUID
    var configuration: ProblemSetConfiguration
    // Kept clean to save
    private(set) var problems: [QuizProblem]
    // Used in Quiz View
    private var unansweredProblems: [QuizProblem]
    private var answeredProblems: [QuizProblem] = []

    private var timer: Timer?
    
    var timeString: String {
        let minutes = Int(remainingSeconds / 60)
        let seconds = Int(remainingSeconds.truncatingRemainder(dividingBy: 60))
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(minutes):\(secondsString)"
    }

    var questionsCountString: String {
        "\(answeredProblems.count)/\(problemCount)"
    }
    
    var startTime: Date = .now
    var endTime: Date = .now
    
    private var cancellables = [AnyCancellable]()
//    private var cancellables: AnyCancellable? = nil
    private var problemCountCancellable = [AnyCancellable]()
    
   
        // MARK: - Lifecycle -
    
    init(config: ProblemSetConfiguration) {
        id = UUID()
        
        configuration = config
        problems = ProblemGenerator.problemSet(for: config)
        unansweredProblems = problems
    }
    
    
        // MARK: - Public -

    func showCountdown() {
        showCountdownSheet = true
    }
    
    func start() {
        if configuration.timeLimit > 0 {
            remainingSeconds = TimeInterval(configuration.timeLimit * 60.0)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.remainingSeconds -= 1
                
                if self.remainingSeconds <= 0 {
                    self.end()
                }
            }
            timer?.fire()
        }
        
//        quizInProgress = true
        next()
    }
    
    
    func end() {
        timer?.invalidate()
        endTime = .now
        
//        quizInProgress = false
        quizComplete = true
        cancellables.forEach { $0.cancel() }
        cancellables = []
        
        print("\n>>>>>>>>>>> END <<<<<<<<<<<<<")
        print("\nanswered: \(answeredProblems.count)")
        answeredProblems.forEach { print($0)}
        print("\nunanswered: \(unansweredProblems.count)")
        unansweredProblems.forEach { print($0)}
        print("\noriginal: \(problems.count)")
        problems.forEach { print($0)}
    }
    
    
    func next() {
        cancellables.forEach { $0.cancel() }
        
        currentProblem = unansweredProblems.removeFirst()
        
        currentProblem?
            .$selectedSolution
            .sink { solution in
                if self.unansweredProblems.isEmpty && self.currentProblem == nil {
                    self.end()
                    return
                }

                if solution == nil { return }
                
                if let problem = self.currentProblem {
                    self.moveToAnswered(problem)
                    
                    if self.unansweredProblems.isEmpty == false {
                        self.next()
                    }
                    else { self.end() }
                }
            }
            .store(in: &cancellables)
    }
    
    func skip() {
        guard
            let currentProblem
        else { return }
        
        unansweredProblems.append(currentProblem)
        next()
    }
    

    func moveToAnswered(_ problem: QuizProblem) {
       answeredProblems.append(problem)
    }
    
    
    func skipProblem() {
        guard let problem = currentProblem
        else { return }
        
        problems.append(problem)
    }
    
}


extension ProblemSet {
    
    func configForTesting() {
//        let endTime = Date.now
//        let startTime = endTime.addingTimeInterval(-(3 * 60))
        let halfOfProblems = Int(problemCount / 2)
        
        for index in 0...(halfOfProblems) {
            let problem = problems[index]
            problem.selectedSolution = problem.correctSolution
        }
        
        for index in halfOfProblems...(problemCount - 1) {
            let problem = problems[index]
            problem.selectedSolution = problem.solutions.first { $0 != problem.correctSolution }
        }
    }
}


