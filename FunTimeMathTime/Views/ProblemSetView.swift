//
//  ProblemSetView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI


struct ProblemSetView: View {
//    @State private var snappedItem = 0.0
//    @State private var draggingItem = 0.0

//    @EnvironmentObject private var problemSet: ProblemSet
//    @State private var currentProblem: Problem
    // MARK: - Lifecycle -
    
//    init(problemSet: ObservedObject<ProblemSet>) {
    init() {
    }
    
    
    var body: some View {
        Circle()
//        ProblemView(problem: currentProblem)
//            .onAppear {
//                _currentProblem = State(initialValue: problemSet.unansweredProblems.first!)
//            }
        
//        ScrollView(.horizontal) {
//            LazyHStack {
////                ForEach(problemSet.unansweredProblems) { problem in
//                ForEach(1..<10) { _ in
//                    Rectangle()
//                        .fill(.orange)
//                        .frame(width: 600, height: 600)
////                    ProblemView(problem: problem)
////                        .padding()
//                }
//                
//            }
//            .scrollTargetLayout()
//        }
//        .scrollTargetBehavior(.viewAligned)
//        .scrollIndicators(.hidden)
//        .frame(maxHeight: 350)
//        .padding()
//        .border(.red)

        
//        ZStack {
//            ForEach(problemSet.unansweredProblems) { problem in
//                if problem.selectedSolution == nil {
//                    ZStack {
//                        ProblemView(problem: problem)
//                    }
//                    .scaleEffect(1.0 - abs(distance(problem.index)) * 0.45 )
//                    .opacity(1.0 - abs(distance(problem.index)) * 0.84 )
//                    .offset(x: myXOffset(problem.index) * 1.5, y: 0)
//                    .zIndex(1.0 - abs(distance(problem.index)) * 0.1)
                        //                .border(.blue)
//                    .onTapGesture {
//                        
//                    }
//                }
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: 300)
//        .padding()
//        .border(.red)
//        .gesture(
//            DragGesture()
//                .onChanged { value in
//                    draggingItem = snappedItem + value.translation.width / 100
//                }
//                .onEnded { value in
//                    withAnimation {
//                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
//                        draggingItem = round(draggingItem).remainder(dividingBy: Double(problemSet.unansweredCount))
//                        snappedItem = draggingItem
//                    }
//                }
//        )
    }
    
    
//    func distance(_ item: Int) -> Double {
//        (draggingItem - Double(item)).remainder(dividingBy: Double(problemSet.unansweredCount))
//    }
//
//    func myXOffset(_ item: Int) -> Double {
//        let angle = Double.pi * 2 / Double(problemSet.unansweredCount) * distance(item)
//        return sin(angle) * 200
//    }

}


#Preview {
    let config = ProblemSetConfiguration(problemType: .addition,
                                                           problemCount: 30,
                                                           timeLimit: 3,
                                                           valueRange: 2...12,
                                                           selectedValues: [3, 7, 9],
                                                           randomize: true)
    
    @StateObject var problems = ProblemSet(config: config)
    
    
    return ProblemSetView()
        .frame(maxWidth: .infinity)
        .padding()
        .environmentObject(problems)
}

//    private var problemSetView: some View {
//        ScrollView(.horizontal) {
//            HStack {
//                ForEach(problemSet.unansweredProblems) { problem in
//                    ProblemView(problem: problem)
//                        .scrollTarget()
//                        .padding()
//                        .border(.red)
//                }
//            }
//            .scrollTargetLayout()
//            
//            Spacer()
//        }
//        .scrollTargetBehavior(.viewAligned)
//        .scrollIndicators(.hidden)
//        .frame(maxHeight: 250)
//        .padding()
//        .border(.red)
//    }
