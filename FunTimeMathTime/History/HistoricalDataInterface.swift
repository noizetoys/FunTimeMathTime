//
//  HistoricalDataInterface.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/30/23.
//

import Foundation
import Observation


@Observable
class HistoricalDataInterface {
    static let shared = HistoricalDataInterface()
    
    var problemSets: [HistoricalProbSet] = []
    
    
    private init() {
        
    }
    
    
    func save(problemSet: QuizProblemSet, config: ProblemSetConfiguration) {
        
    }
    
    
//    func
    
}
