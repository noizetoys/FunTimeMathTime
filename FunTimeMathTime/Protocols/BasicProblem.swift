//
//  Problem.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/27/23.
//

import Foundation


protocol BasicProblem: Identifiable {
    var id: UUID { get }
    
    var topValue: Int { get }
    var bottomValue: Int { get }
    var problemType: ProblemType { get }
    
    var correctSolution: Solution { get }
    var selectedSolution: Solution? { get }
}


extension BasicProblem {
    var correctSolutionChosen: Bool { correctSolution == selectedSolution }
}
