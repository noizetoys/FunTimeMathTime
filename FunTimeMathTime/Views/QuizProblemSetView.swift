//
//  QuizProblemSetView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI


class ProblemSet: ObservableObject {
    private(set) var problems: [Problem]
    
    private(set) var config: ProblemSetConfiguration
    
    init(config: ProblemSetConfiguration) {
        self.config = config
        problems = ProblemGenerator.problemSet(for: config)
        
        var index = 1
        problems.forEach { problem in
            problem.index = index
            index += 1
        }
    }
    
    
    var count: Int {
        problems.count
    }
    
}


struct QuizProblemSetView: View {
    @StateObject private var problemSet: ProblemSet
    
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0

    
    private let config: ProblemSetConfiguration
    
    
    // MARK: - Lifecycle -
    
    init(config: ProblemSetConfiguration) {
        self.config = config
        _problemSet = StateObject(wrappedValue: ProblemSet(config: config))
    }
    
    
    var body: some View {
        ZStack {
            
            ForEach(problemSet.problems) { problem in
                ZStack {
                    ProblemView(problem: problem)
                }
//                .frame(width: 800, height: 00)
                .scaleEffect(1.0 - abs(distance(problem.index)) * 0.45 )
                .opacity(1.0 - abs(distance(problem.index)) * 0.84 )
                .offset(x: myXOffset(problem.index) * 1.5, y: 0)
                .zIndex(1.0 - abs(distance(problem.index)) * 0.1)
//                .border(.blue)
                .onTapGesture {
                    
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .padding()
//        .border(.red)
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(problemSet.count))
                        snappedItem = draggingItem
                    }
                }
        )
        .onTapGesture {
            
        }
    }
    
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(problemSet.count))
    }

    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(problemSet.count) * distance(item)
        return sin(angle) * 200
    }

}


#Preview {
//    ScrollView(.horizontal) {
        QuizProblemSetView(config: ProblemSetConfiguration(problemType: .addition,
                                                           problemCount: 30,
                                                           timeLimit: 3,
                                                           valueRange: 2...12,
                                                           selectedValues: [3, 7, 9],
                                                           randomize: true))
        .frame(maxWidth: .infinity)
        .padding()
//    }
}

    //struct ContentView: View {
    //
    //    @StateObject var store = Store()
    //    @State private var snappedItem = 0.0
    //    @State private var draggingItem = 0.0
    //
//        var body: some View {
//    
//            ZStack {
//                ForEach(store.items) { item in
//
//                    // article view
//                ZStack {
//                    RoundedRectangle(cornerRadius: 18)
//                        .fill(item.color)
//                    Text(item.title)
//                        .padding()
//                }
//                .frame(width: 200, height: 200)
//                
//                .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
//                .opacity(1.0 - abs(distance(item.id)) * 0.3 )
//                .offset(x: myXOffset(item.id), y: 0)
//                .zIndex(1.0 - abs(distance(item.id)) * 0.1)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { value in
//                    draggingItem = snappedItem + value.translation.width / 100
//                }
//                .onEnded { value in
//                    withAnimation {
//                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
//                        draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
//                        snappedItem = draggingItem
//                    }
//                }
//        )
//    }
//    
//    func distance(_ item: Int) -> Double {
//        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
//    }
//    
//    func myXOffset(_ item: Int) -> Double {
//        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
//        return sin(angle) * 200
//    }
//    
//}


    //struct Item: Identifiable {
    //    var id: Int
    //    var title: String
    //    var color: Color
    //}
    //
    //class Store: ObservableObject {
    //    @Published var items: [Item]
    //
    //    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]
    //
    //        // dummy data
    //    init() {
    //        items = []
    //        for i in 0...7 {
    //            let new = Item(id: i, title: "Item \(i)", color: colors[i])
    //            items.append(new)
    //        }
    //    }
    //}
    //
    //
