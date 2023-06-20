//
//  ProblemGenerator.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import Foundation


class ProblemGenerator {
    static func problemSet(for config: ProblemSetConfiguration) -> [Problem] {
        print("\nProblemGenerator: generating problem sets for config: \(config)")
        
        var allProblems: Set<Problem> = []
        
        for topValue in config.selectedValues {
            for bottomValue in config.valueRange {
                allProblems.insert(Problem(topValue: topValue,
                                            bottomValue: bottomValue,
                                            problemType: config.problemType))
            }
        }
        
        print("\nProblemGenerator: allProblems = \(allProblems.count)")
//        guard
//            config.randomize
//        else { return allProblems }
//        
        var problemSet = Set<Problem>()
        
        for _ in 1...config.problemCount {
            guard
                let selectedProblem = allProblems.randomElement()
            else {
                return []
            }
            
            let isDupe = problemSet.contains(selectedProblem)
//            print("ProblemGenerator: It's a dupe!!!")
            
            problemSet.insert(isDupe ? selectedProblem.duplicate() : selectedProblem)
        }
        
        
        print("\nProblemGenerator: problemSet = \(problemSet.count)")
        var shuffledSet = Array(problemSet).shuffled().shuffled()
        
        var index = 0
        
        for problem in shuffledSet {
            problem.index = index
            index += 1
        }
        
        return shuffledSet
    }
    
    
}

