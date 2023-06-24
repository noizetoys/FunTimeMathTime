//
//  QuizCompleteView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/22/23.
//

import SwiftUI

struct QuizCompleteView: View {
    @Environment(\.dismiss) private var dismiss
    var problemSet: ProblemSet
    
    var body: some View {
        VStack {
            Text("Time's Up!")
                .font(.system(size: 64, weight: .black))
                .italic()
            
            Spacer()
                .frame(height: 50)
            
            VStack(alignment: .center, spacing: 20) {
                Text("Total Problems: \(problemSet.totalCount)")
                Text("Answered: \(problemSet.answeredCount)")
                Text("Not Answered: \(problemSet.unansweredCount)")
            }
            .font(.system(size: 38, weight: .bold))

            Spacer()
                .frame(height: 50)
            
            Text("Correctly Answered: \(problemSet.correctlyAnswered)")
                .font(.system(size: 52, weight: .black, design: .none))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onTapGesture {
            dismiss()
        }
    }
    
}


#Preview {
    var config: ProblemSetConfiguration = ProblemSetConfiguration(problemType: .addition,
                                                                  problemCount: 30,
                                                                  valueRange: 2...12,
                                                                  selectedValues: [5, 9])
    var problemSet: ProblemSet = ProblemSet(config: config)
//    problemSet.configForTesting()
    
    return QuizCompleteView(problemSet: problemSet)
}
