//
//  ProblemTypeCell.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI


struct ProblemTypeCell: View {
    @Binding var selectedType: ProblemType
    let type: ProblemType
    
    private var isSelected: Bool { type == selectedType }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(isSelected ? .green : .white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 4.0)
                }

            
            type.sign
                .resizable()
                .scaledToFit()
                .padding()
        }
        .frame(width: 100, height: 100)
        .padding()
    }
    
}


        
//#Preview {
//    ProblemTypePickerView()
//}
