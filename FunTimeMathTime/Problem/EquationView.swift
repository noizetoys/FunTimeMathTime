//
//  EquationView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI

struct EquationView: View {
    let equation: Equation
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("\(equation.topValue)")
            }
            
            HStack {
                equation.equationType.sign
                Text("\(equation.bottomValue)")
            }
        }
    }
    
}


#Preview {
    EquationView(equation: Equation(topValue: 9, bottomValue: 9, equationType: .addition))
}
