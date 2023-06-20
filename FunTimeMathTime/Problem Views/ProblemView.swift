//
//  ProblemView.swift
//  GenTest
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI


struct ProblemView: View {
    @State private(set) var selectedSolution: Solution?
    @State private var solutionSelected: Bool = false
    @State private var correctSolutionSelected: Bool = false
    
    private let problem: Problem
    private let solutions: [Solution]
    private let correctSolution: Solution
    
    
        // MARK: - Lifecycle -
    
    init(problem: Problem) {
//        print("ProblemView: init:  \(problem)")
        self.problem = problem
        self.solutions = problem.choices
        self.correctSolution = problem.solution
    }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
//                .foregroundColor(foreGroundColor.opacity(0.7))
                .foregroundColor(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(.blue, lineWidth: 10.0)
                        .stroke(.black, lineWidth: 10.0)
                }
                .padding(5)

            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    
                    EquationView(problem: problem)
                    
                    Spacer()
                }
                
                Rectangle()
                    .frame(width: 400, height: 4)
                    .padding(.top, -20)
                
                HStack {
                    ForEach(solutions) { solution in
                        let selected = solution == selectedSolution
                        let isCorrectAnswer = solution == correctSolution
                        
                        SolutionView(solution: solution,
                                     isCorrectSolution: isCorrectAnswer,
                                     selected: selected,
                                     solutionSelected: solutionSelected)
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                if solution == selectedSolution {
                                    selectedSolution = nil
                                    solutionSelected = false
                                }
                                else {
                                    selectedSolution = solution
                                    solutionSelected = true
                                }
                            }
                            .padding(.horizontal, 10)
//                            .padding()
                    }
                    
                } // HSTACK - Solutions

            } // VStack
            .padding(.vertical, 30)
//            .background(.blue.opacity(0.3))
//            .background(.white)
            .cornerRadius(10)
            .font(.largeTitle)
            .bold()
            
        } // ZStack
        .frame(width: 450)
    }
    
    
}


#Preview {
    ScrollView(.vertical) {
        ProblemView(problem: Problem(topValue: 10, bottomValue: 10, problemType: .addition))
        ProblemView(problem: Problem(topValue: 10, bottomValue: 10, problemType: .subtraction))
        ProblemView(problem: Problem(topValue: 10, bottomValue: 10, problemType: .multiplication))
        ProblemView(problem: Problem(topValue: 10, bottomValue: 10, problemType: .division))
            //        EquationView(problem: Problem(topValue: 9, bottomValue: 8, ProblemType: .subtraction))
            //        EquationView(problem: Equation(topValue: 8, bottomValue: 7, ProblemType: .multiplication))
            //        EquationView(problem: Equation(topValue: 10, bottomValue: 10, ProblemType: .division))
    }
    .background(.orange)
}
