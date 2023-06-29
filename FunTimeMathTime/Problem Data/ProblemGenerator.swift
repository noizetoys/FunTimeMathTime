//
//  ProblemGenerator.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import Foundation


class ProblemGenerator {
    static func problemSet(for config: ProblemSetConfiguration) -> [QuizProblem] {
        var allProblems: Set<QuizProblem> = []
        
        for topValue in config.selectedValues {
            for bottomValue in config.valueRange {
                allProblems.insert(QuizProblem(topValue: topValue,
                                            bottomValue: bottomValue,
                                            problemType: config.problemType))
            }
        }
        
        var problemSet = Set<QuizProblem>()
        
        for _ in 1...Int(config.problemCount) {
            guard
                let selectedProblem = allProblems.randomElement()
            else {
                return []
            }
            
            let isDupe = problemSet.contains(selectedProblem)
            
            problemSet.insert(isDupe ? selectedProblem.duplicate() : selectedProblem)
        }
        
        
        let shuffledSet = Array(problemSet).shuffled().shuffled()
        
        var index = 0
        
        for problem in shuffledSet {
            problem.index = index
            index += 1
        }
        
        return shuffledSet
    }
    
    
}

