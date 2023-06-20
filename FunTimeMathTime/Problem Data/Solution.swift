//
//  Solution.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import Foundation


struct Solution: Identifiable, Equatable {
    let id = UUID()
    
    let result: Int
    let remainder: Int?
    let problemType: ProblemType
    
    init(result: Int, remainder: Int? = nil, type: ProblemType) {
        self.result = result
        self.remainder = remainder
        self.problemType = type
    }
}


