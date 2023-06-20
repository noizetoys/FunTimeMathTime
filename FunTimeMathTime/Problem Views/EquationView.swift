//
//  EquationView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI

struct EquationView: View {
    let problem: Problem
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("\(problem.topValue)")
            }
            
            HStack {
                problem.problemType.sign
                Text("\(problem.bottomValue)")
            }
        }
    }
    
}


#Preview {
    EquationView(problem: Problem(topValue: 9, bottomValue: 9, problemType: .addition))
}
