//
//  ProblemView.swift
//  GenTest
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI


struct ProblemView: View {
    private var problem: QuizProblem
    
    @State private var solutionSelected: Bool = false
    @State private var correctSolutionSelected: Bool = false
    
    
        // MARK: - Lifecycle -
    
    init(problem: QuizProblem?) {
        self.problem = problem ?? QuizProblem(topValue: 0, bottomValue: 0, problemType: .addition)
    }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
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
                    .frame(width: 200, height: 4)
                    .padding(.top, -20)
                
                HStack {
                    ForEach(problem.solutions) { solution in
                        SolutionView(solution: solution,
                                     isCorrectSolution: solution == problem.correctSolution,
                                     selected: solution == problem.selectedSolution,
                                     solutionSelected: solutionSelected)
                            .frame(width: 80, height: 80)
                            .onTapGesture {
                                withAnimation {
                                    problem.selectedSolution = solution
                                }
                            }
                            .padding(.horizontal, 10)
                    }
                    
                } // HSTACK - Solutions

            } // VStack
            .padding(.vertical, 30)
            .cornerRadius(10)
            .font(.largeTitle)
            .bold()
            
        } // ZStack
//        .frame(width: 200)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}


//#Preview {
//    ScrollView(.vertical) {
//        ProblemView(problem: QuizProblem(topValue: 10, bottomValue: 10, problemType: .addition))
//        ProblemView(problem: QuizProblem(topValue: 10, bottomValue: 10, problemType: .subtraction))
//        ProblemView(problem: QuizProblem(topValue: 10, bottomValue: 10, problemType: .multiplication))
//        ProblemView(problem: QuizProblem(topValue: 10, bottomValue: 10, problemType: .division))
//            //        EquationView(problem: Problem(topValue: 9, bottomValue: 8, ProblemType: .subtraction))
//            //        EquationView(problem: Equation(topValue: 8, bottomValue: 7, ProblemType: .multiplication))
//            //        EquationView(problem: Equation(topValue: 10, bottomValue: 10, ProblemType: .division))
//    }
////    .background(.orange)
//}
