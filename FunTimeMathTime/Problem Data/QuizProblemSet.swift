//
//  QuizProblemSet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/20/23.
//


import SwiftUI
import Combine
import Observation


@Observable
class QuizProblemSet: ProblemSet {
    var currentProblem: QuizProblem? = nil
    var remainingSeconds: TimeInterval = 0
    var showCountdownSheet: Bool = false
    
    var id: UUID = UUID()
    var configuration: ProblemSetConfiguration = ProblemSetConfiguration()
    // Kept clean to save
    private(set) var problems: [QuizProblem] = []
    // Used in Quiz View
    private var unansweredProblems: [QuizProblem] = []
    private var answeredProblems: [QuizProblem] = []

    private var timer: Timer? = nil
    
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
        
        next()
    }
    
    
    func end() {
        timer?.invalidate()
        endTime = .now
        
        cancellables.forEach { $0.cancel() }
        cancellables = []
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
                    self.answeredProblems.append(problem)
                    
                    if self.unansweredProblems.isEmpty == false {
                        self.next()
                    }
                    else { self.end() }
                }
            }
            .store(in: &cancellables)
    }
    
    
    func skip() {
        guard let currentProblem
        else { return }
        
        unansweredProblems.append(currentProblem)
        next()
    }
    

    func skipProblem() {
        guard let problem = currentProblem
        else { return }
        
        problems.append(problem)
    }
    
}


extension QuizProblemSet: CustomStringConvertible {
    var description: String {
        """
        problemType: \(problemType.rawValue)
        valueRange: \(valueRange)
        selectedValues: \(selectedValues)
        selectedValues: \(selectedValues)
        
        problemCount: \(problemCount)
        answered: \(answeredProblems.count)
        unanswered: \(unansweredProblems.count)
        
        time: \(endTime.timeIntervalSince(startTime).minutesSeconds)
        """
    }
}


extension QuizProblemSet {
    
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


