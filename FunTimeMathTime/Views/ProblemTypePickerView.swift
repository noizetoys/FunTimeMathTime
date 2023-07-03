//
//  ProblemTypePickerView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI


struct ProblemTypePickerView: View {
    @Environment(QuizEngine.self) private var quizEngine: QuizEngine

    @State private var showConfigView: Bool = false
//    @State private var paths: [ProblemSetConfiguration] = []
    
    
    
    var body: some View {
//        NavigationStack(path: $paths) {
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
                // DIMISS
//                QuizView()
            } content: {
                ProblemsConfigView()
            }
//            .navigationDestination(for: ProblemSetConfiguration.self) { config in
//                QuizView()
//            }
//        }
        
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
            print("ProblemTypePickerView: type = \(type.rawValue) Selected")
//            selectedType = type
            quizEngine.problemSetConfig.problemType = type
            print("ProblemTypePickerView: quizEngine.problemSetConfig.problemType = \(quizEngine.problemSetConfig.problemType)")
            showConfigView.toggle()
        }
        
    }
    
}



#Preview {
    ProblemTypePickerView()
}
