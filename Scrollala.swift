//
//  Scrollala.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI


fileprivate let probSet: [Problem] = [
    Problem(topValue: 5, bottomValue: 2, problemType: .addition),
    Problem(topValue: 5, bottomValue: 3, problemType: .addition),
    Problem(topValue: 5, bottomValue: 4, problemType: .addition),
    Problem(topValue: 5, bottomValue: 5, problemType: .addition),
    Problem(topValue: 5, bottomValue: 6, problemType: .addition),
    Problem(topValue: 5, bottomValue: 7, problemType: .addition),
    Problem(topValue: 5, bottomValue: 8, problemType: .addition),
    Problem(topValue: 5, bottomValue: 9, problemType: .addition),
    Problem(topValue: 5, bottomValue: 10, problemType: .addition),
    Problem(topValue: 5, bottomValue: 11, problemType: .addition),
    Problem(topValue: 5, bottomValue: 12, problemType: .addition),
]

#Preview {
    let config = ProblemSetConfiguration(problemType: .addition,
                                         problemCount: 10,
                                         valueRange: 2...12,
                                         selectedValues: [5])
    
    var probs = [Problem]()
    var index = 1
    
    for problem in probSet {
        problem.index = index
        index += 1
    }
    
    return Scrollala(config: config)
}





struct Scrollala: View {
    
    @StateObject var problemSet: ProblemSet
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State private var unanswered: [Problem] = []
    
    
    init(config: ProblemSetConfiguration) {
        _problemSet = StateObject(wrappedValue: ProblemSet(config: config))
    }
    
    
    var body: some View {
        
        ZStack {
            ForEach(problemSet.problems) { item in
                
                ZStack {
                    ProblemView(problem: item)
                }
                .frame(width: 800, height: 200)
                .scaleEffect(1.0 - abs(distance(item.index)) * 0.45 )
                .opacity(1.0 - abs(distance(item.index)) * 0.84 )
                .offset(x: myXOffset(item.index), y: 0)
                .zIndex(1.0 - abs(distance(item.index)) * 0.1)
                .onTapGesture {
                    
                }
            }
        }
//        .border(.red)
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(problemSet.unansweredCount))
                        snappedItem = draggingItem
                    }
                }
        )
        .onTapGesture {
            
        }
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(problemSet.unansweredCount))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(problemSet.unansweredCount) * distance(item)
        return sin(angle) * 700
    }
    
}
