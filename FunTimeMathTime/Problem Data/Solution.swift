//
//  Solution.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import Foundation
//import SwiftData


//@Model
//struct Solution: Identifiable, Equatable, Codable {
//struct Solution: Identifiable, Equatable {
class Solution: Identifiable, Codable {
//    @Attribute(.unique) var id: UUID
    var id: UUID
    
    var result: Int
    var remainder: Int?
    
    
    init(result: Int, remainder: Int? = nil) {
        self.result = result
        self.remainder = remainder
        id = UUID()
    }
    
}

extension Solution: Equatable {
    static func == (lhs: Solution, rhs: Solution) -> Bool {
        lhs.id == rhs.id
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

