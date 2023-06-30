//
//  Solution.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import Foundation
import SwiftData


//@Model
struct Solution: Identifiable, Equatable, Codable {
    let id: UUID
    
    let result: Int
    let remainder: Int?
    
    
    init(result: Int, remainder: Int? = nil) {
        self.result = result
        self.remainder = remainder
        id = UUID()
    }
    
}


extension Solution {
    var resultText: String { "\(result)" }
    
    var remainderText: String {
        guard
            let reminderValue = remainder,
            reminderValue > 0
        else {
            return ""
        }
        
        return "R: \(reminderValue)"
    }
    
    
    var fullText: String {
        resultText + (containsRemainder ? " \(remainderText)" : "")
    }
    
    var containsRemainder: Bool {
        guard
            let remainder,
            remainder > 0
        else { return false}
        
        return true
    }
}


extension Solution: CustomStringConvertible {
    var description: String {
        fullText
    }
    
    
}

