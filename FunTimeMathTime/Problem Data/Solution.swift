//
//  Solution.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import Foundation
import SwiftData


@Model
class Solution: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var result: Int
    var remainder: Int
    
    
    init(result: Int, remainder: Int = 0) {
        self.result = result
        self.remainder = remainder
        id = UUID()
    }
    
}


extension Solution: Equatable {
    static func == (lhs: Solution, rhs: Solution) -> Bool { lhs.id == rhs.id }
}


extension Solution {
    var resultText: String { "\(result)" }
    var fullText: String { resultText + (containsRemainder ? " \(remainderText)" : "") }
    
    var remainderText: String {
        guard containsRemainder
        else { return "" }
        
        return "R: \(remainder)"
    }
    
    
    var containsRemainder: Bool {
        guard remainder > 0
        else { return false}
        
        return true
    }
}


extension Solution: CustomStringConvertible {
    var description: String {
        fullText
    }
    
}

