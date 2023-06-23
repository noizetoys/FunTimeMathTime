//
//  ProblemTypePickerView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI


struct ProblemTypePickerView: View {
    @EnvironmentObject var problemSetConfig: ProblemSetConfiguration
    
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
                paths.append(problemSetConfig)
            } content: {
                ProblemsConfigView()
            }
            .navigationDestination(for: ProblemSetConfiguration.self) { config in
                QuizView(config: config)
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
            problemSetConfig.problemType = type
            showConfigView.toggle()
        }
        
    }
    
}



#Preview {
    ProblemTypePickerView()
}
