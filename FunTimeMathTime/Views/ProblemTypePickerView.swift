//
//  ProblemTypePickerView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI


struct ProblemTypePickerView: View {
    @Environment(QuizEngine.self) private var quizEngine: QuizEngine

    @State private var selectedType: ProblemType = .addition
    @State private var showConfigView: Bool = false
    
    @State private var paths: [ProblemSetConfiguration] = []
    
    
    
    var body: some View {
        NavigationStack(path: $paths) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.clear)
                    .border(Color.black, width: 2)
                
                Grid {
                    GridRow {
                        ProblemTypeSelectionCell(for: .addition)
                        ProblemTypeSelectionCell(for: .subtraction)
                    }
                    GridRow {
                        ProblemTypeSelectionCell(for: .multiplication)
                        ProblemTypeSelectionCell(for: .division)
                    }
                }
            }
            .padding()
            .sheet(isPresented: $showConfigView) {
                quizEngine.newProblemSet()
                paths.append(quizEngine.problemSetConfig)
            } content: {
                ProblemsConfigView()
            }
            .navigationDestination(for: ProblemSetConfiguration.self) { config in
                QuizView()
            }
        }
        
    }
    

    func ProblemTypeSelectionCell(for type: ProblemType) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.blue.opacity(0.5))
            
            type.sign
                .resizable()
                .scaledToFit()
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onTapGesture {
            selectedType = type
            quizEngine.problemSetConfig.problemType = type
            showConfigView.toggle()
        }
        
    }
    
}



#Preview {
    ProblemTypePickerView()
}
