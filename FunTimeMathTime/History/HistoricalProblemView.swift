//
//  HistoricalProblemView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/27/23.
//

import SwiftUI


struct HistoricalProblemView: View {
    @State private var visibleSolution: Solution
    @State private var showingCorrectAnswer: Bool = false
    
    private let problem: any BasicProblem
    
    private let correctColor = Color.green.opacity(0.5)
    private let incorrectColor = Color.red.opacity(0.5)
    private var correctText: String { problem.correctSolution.fullText }
    private var incorrectText: String { problem.selectedSolution?.fullText ?? "N/A" }
    
    
    init(problem: any BasicProblem) {
        self.problem = problem
        _visibleSolution = State(initialValue: problem.selectedSolution ?? problem.correctSolution)
    }
                             
    
    var body: some View {
            VStack(alignment: .center) {
                
                HStack {
                    Spacer()
                    EquationView(problem: problem)
                    Spacer()
                }
                
                Rectangle()
                    .frame(width: 80, height: 4)
                    .padding(.top, -10)
                
                HStack {
                    if problem.selectedSolution != nil {
                        if problem.correctSolutionChosen {
                            correctAnswerView
                        }
                        else {
                            inCorrectAnswerView
                                .onTapGesture {
                                    showingCorrectAnswer.toggle()
                                }
                        }
                    }
                    else {
                        Text("---")
                    }

                } // HSTACK - Solutions
                
            } // VStack
            .frame(width: 100)
            .cornerRadius(10)
            .font(.title)
            .bold()
            
    }
    
   
        // MARK: - Private Views -
    
    private var correctAnswerView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.clear)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                Text(correctText)
            }
            
        }
        .frame(width: 80, height: 80)
        
    }

    private var inCorrectAnswerView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(showingCorrectAnswer ? correctColor : incorrectColor )
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                Text(showingCorrectAnswer ? correctText : incorrectText)
            }
            
        }
        .frame(width: 80, height: 80)

    }
    
}


#Preview {
    let correctSolution = Solution(result: 1, remainder: 1)
    let correctProblem = HistoricalProblem(id: UUID(),
                                           topValue: 9,
                                           bottomValue: 8,
                                           problemType: .division,
                                           correctSolution: correctSolution,
                                           selectedSolution: correctSolution)
    let incorrectSolution = Solution(result: 3)
    let inCorrectProblem = HistoricalProblem(id: UUID(),
                                           topValue: 9,
                                           bottomValue: 8,
                                           problemType: .division,
                                           correctSolution: correctSolution,
                                           selectedSolution: incorrectSolution)
    
    let numberOfProblems = 40
//    let maxNumberOfItems = 10
    
    var rows: [GridItem] {
        var theRows = [GridItem]()
        
        let numberOfProblems = 40
        let maxNumberOfItems = 8

        let numOfRows = Int(numberOfProblems/maxNumberOfItems)

        for _ in 1...numOfRows {
            let item = GridItem(.flexible(), spacing: 20, alignment: .center)
            theRows.append(item)
        }
        return theRows
    }
    
    
    return ScrollView(.vertical) {
        LazyHGrid(rows: rows, spacing: 30) {
            ForEach(1...numberOfProblems, id: \.self) { _ in
                HistoricalProblemView(problem: Bool.random() ? correctProblem : inCorrectProblem)
            }
        }
    }
}
