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
    
//    init(from decoder: Decoder) throws {
//        
//    }
}


