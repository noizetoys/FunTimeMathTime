//
//  QuizData.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import Foundation


class QuizData {
    let config: ProblemSetConfiguration
    let problemSet: [Problem]
    
   
        // MARK: - Lifecycle -

    init(config: ProblemSetConfiguration, problemSet: [Problem]) {
        self.config = config
        self.problemSet = problemSet
    }
    
    
    // time
    // # of remaing problems
    // Score? right/total
    // cancel action
    
    // setting access
    // show answer?
    // Score?
    // ???
}
