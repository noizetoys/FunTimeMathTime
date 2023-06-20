//
//  ProblemTypePickerView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI

struct ProblemTypePickerView: View {
    @State private var selectedType: ProblemType = .addition
    @State private var showConfigView: Bool = false
    
    @State var problemSetConfig: ProblemSetConfiguration?
    
    
    var body: some View {
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
            print("\nProblemTypePickerView:  Dismissed ProblemsConfigView")
        } content: {
            ProblemsConfigView(type: selectedType, config: $problemSetConfig)
        }
        .onChange(of: problemSetConfig, initial: false) { oldConfig, newConfig in
            print("\nProblemTypePickerView: onChange: OLD config = \(oldConfig?.debugDescription ?? "No description")")
            print("\nProblemTypePickerView: onChange: config = \(newConfig?.debugDescription ?? "No description")")
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
            showConfigView.toggle()
        }
        
    }
    
}



#Preview {
    ProblemTypePickerView()
}
