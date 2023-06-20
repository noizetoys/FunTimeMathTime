//
//  SolutionView.swift
//  GenTest
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI


struct SolutionView: View, Identifiable {
    var id = UUID()
    
    var solution: Solution
    var selected: Bool
    var isCorrectAnswer: Bool
    private let dim: Bool
    
    private var borderColor: Color { !dim || selected ? .black : .gray }
    private var borderLineWidth: CGFloat { !dim || selected ? 6.0 : 2.0 }
    
    private var foreGroundColor: Color {
        guard selected
        else { return .clear }
        
        return isCorrectAnswer ? .green : .red
    }
    
    private var textColor: Color {
        guard !dim
        else { return .gray }
        
        return selected && isCorrectAnswer ? .red : .orange
    }
    
    
    
    init(solution: Solution, isCorrectSolution: Bool, selected: Bool, solutionSelected: Bool) {
        self.solution = solution
        self.selected = selected
        dim = solutionSelected
        isCorrectAnswer = isCorrectSolution
    }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(foreGroundColor.opacity(0.7))
                .background(.white)
//                .background(.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: borderLineWidth)
                }
            
            VStack {
                Text("\(solution.result)")
                    .font(.title)
                
                if let remainder = solution.remainder, remainder > 0 {
                    Text("R: \(remainder)")
                        .font(.title)
                }
            }
            
        }
        .bold(!dim || selected)
        .frame(height: 100)
        
    }
}


fileprivate struct SolutionPreviewView: View {
    var result: Int
    var remainder: Int
    var isCorrectSolution: Bool
    var type: ProblemType
    
    @State var selected: Bool
    @State var solutionSelected: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(selected ? "Selected" : "NOT Selected")
                    .font(selected ? .title2 : .title)
                    .bold(!selected)
                
                Text(solutionSelected ? "Solution Selected" : "Solution NOT Selected")
                    .font(solutionSelected ? .title2 : .title)
                    .bold(!solutionSelected)
            }
            .frame(width: 300)
            
            SolutionView(solution: Solution(result: result,
                                            remainder: remainder,
                                            type: type),
                         isCorrectSolution: isCorrectSolution,
                         selected: selected,
                         solutionSelected: solutionSelected)
            .onTapGesture {
                selected.toggle()
                solutionSelected.toggle()
            }
            .frame(maxWidth: 100)
            
            Spacer()
        }
    }
}


#Preview {
    VStack {
        SolutionPreviewView(result: 5, remainder: 0, isCorrectSolution: true, type: .addition, selected: false, solutionSelected: false)
        SolutionPreviewView(result: 5, remainder: 0, isCorrectSolution: true, type: .addition, selected: true, solutionSelected: true)
        SolutionPreviewView(result: 5, remainder: 0, isCorrectSolution: true, type: .addition, selected: false, solutionSelected: true)
        
        SolutionPreviewView(result: 5, remainder: 1, isCorrectSolution: false,  type: .addition, selected: false, solutionSelected: false)
        SolutionPreviewView(result: 5, remainder: 1, isCorrectSolution: false,  type: .addition, selected: true, solutionSelected: true)
        SolutionPreviewView(result: 5, remainder: 1, isCorrectSolution: false,  type: .addition, selected: false, solutionSelected: true)
    }
    .padding()
}


