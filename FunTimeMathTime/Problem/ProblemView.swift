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
    
    private let equation: Equation
    private let solutions: [Solution]
    private let correctSolution: Solution
    
    
        // MARK: - Lifecycle -
    
    init(equation: Equation) {
        self.equation = equation
        self.solutions = equation.choices
        self.correctSolution = equation.solution
    }
    
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                
                EquationView(equation: equation)
                
                Spacer()
            }
            
            Rectangle()
                .frame(width: 400, height: 4)
                .padding(.top, -20)
            
            HStack {
                ForEach(solutions) { solution in
                    let selected = solution == selectedSolution
                    let isCorrectAnswer = solution == correctSolution
                    
                    SolutionView(solution: solution, isCorrectSolution: isCorrectAnswer, selected: selected, solutionSelected: solutionSelected)
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
                }
                
            } // HSTACK - Solutions
            
        }
        .font(.largeTitle)
        .bold()
    }
    
    
}


#Preview {
    ScrollView(.vertical) {
        ProblemView(equation: Equation(topValue: 10, bottomValue: 10, equationType: .addition))
        ProblemView(equation: Equation(topValue: 10, bottomValue: 10, equationType: .subtraction))
        ProblemView(equation: Equation(topValue: 10, bottomValue: 10, equationType: .multiplication))
        ProblemView(equation: Equation(topValue: 10, bottomValue: 10, equationType: .division))
            //        EquationView(equation: Equation(topValue: 9, bottomValue: 8, equationType: .subtraction))
            //        EquationView(equation: Equation(topValue: 8, bottomValue: 7, equationType: .multiplication))
            //        EquationView(equation: Equation(topValue: 10, bottomValue: 10, equationType: .division))
    }
}
