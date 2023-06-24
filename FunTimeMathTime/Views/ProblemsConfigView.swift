//
//  ProblemsConfigView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI


struct ProblemsConfigView: View {
    @EnvironmentObject private var problemSetConfig: ProblemSetConfiguration
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var allValues: [ValueGridItem] = []
    @State private var showAlert: Bool = false
    
    // Settings:
    // Min & Max
    // Max # of questions
    // Auto Random
    
    private var timeLimitText: String {
        let limit = problemSetConfig.timeLimit
        return limit > 0 ? "Time Limit:  \(limit) Minutes" : "No Time Limit"
    }
    
    private let problemCountRange: ClosedRange<Float> = 20...50
    
    private var rows: [GridItem] = [
        GridItem(.flexible(minimum: 40, maximum: 80), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 80), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 80), spacing: 10, alignment: .center),
    ]
    
    
    // MARK: - View
    
    
    var body: some View {
        VStack {
            Text("\(problemSetConfig.problemType.rawValue) Problems")
                .font(.title)
                .bold()
            
            LazyVGrid(columns: rows, alignment: .center, spacing: 10, pinnedViews: [], content: {
                ForEach(problemSetConfig.valueRange, id: \.self) { value in
                    let isSelected = problemSetConfig.selectedValues.contains(where: { $0 == value })
                    
                    ValueGridItem(selected: isSelected, value: value)
                        .onTapGesture {
                            if problemSetConfig.selectedValues.contains(value) {
                                problemSetConfig.selectedValues.append(value)
                            }
                            else {
                                problemSetConfig.selectedValues.append(value)
                            }
                        }
                        .onLongPressGesture {
                            resetAllValues()
                            problemSetConfig.selectedValues.append(value)
                        }
                } // For Each
            })
            
            // Sliders, etc.
            VStack {
                VStack {
                    Text("Total Problem:  \(Int(problemSetConfig.problemCount))")
                    
                    problemCountSlider
                        .frame(width: 300)
                }
                .padding()
                
                VStack {
                    Text(timeLimitText)
                    
                    timerSlider
                        .frame(width: 300)
                }
                .padding(.top)
            }
            .bold()
            .padding(.vertical)
            
            buttonsRow
                .padding(.top)
        }
        .alert("No Numbers Selected!", isPresented: $showAlert) {
            Button("Ok", role: .cancel) { }
        }
        .padding()
    }
    
    
    private func resetAllValues() {
        allValues = []
        
        for value in problemSetConfig.valueRange {
            allValues.append(ValueGridItem(selected: false, value: value))
        }
        
        problemSetConfig.problemCount = 30
        problemSetConfig.timeLimit = 3
        problemSetConfig.selectedValues = []
        problemSetConfig.randomize = true
    }
    
    
        // MARK: - Views -
    
    private var problemCountSlider: some View {
        Slider(value: $problemSetConfig.problemCount,
               in: problemCountRange,
               step: 5,
               label: { Text("Problems") },
               minimumValueLabel: { Text("\(Int(problemCountRange.lowerBound))") },
               maximumValueLabel: { Text("\(Int(problemCountRange.upperBound))") }
        )
    }
    
    
    private var timerSlider: some View {
        Slider(value: $problemSetConfig.timeLimit,
               in: 0...10,
               step: 0.5,
               label: { Text("Timer") },
               minimumValueLabel: { Text("None") },
               maximumValueLabel: { Text("10") }
        )
    }
    
    
    private var randomizeToggle: some View {
        HStack {
            Toggle(isOn: $problemSetConfig.randomize) {
                Text("Randomize Order")
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .bold()
            }
            .frame(width: 350)
        }
        .padding()
    }
    
    
    private var buttonsRow: some View {
        HStack {
            Spacer()
            
                // TODO: HOw to cancel and go back to Problem Type Picker
            cuteButton(title: "Cancel", color: .red) {
                dismiss()
                resetAllValues()
            }
            
            Spacer()
                .frame(width: 100)
            
                // TODO: Select
            cuteButton(title: "Select", color: .green) {
                guard
                    !problemSetConfig.selectedValues.isEmpty
                else {
                    showAlert.toggle()
                    return
                }
                
                dismiss()
            }
            
            Spacer()
        }
    }
    
    
    private func cuteButton(title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .font(.title)
                .bold()
        })
        .frame(maxWidth: 150, maxHeight: 80)
        .background(color)
        .foregroundColor(.white)
        .clipShape(.rect(cornerRadius: 10))
    }
    
}


struct ValueGridItem: View, Identifiable {
    var selected: Bool
    
    var id = UUID()
    var value: Int
    
    init(selected: Bool, value: Int) {
        self.selected = selected
        self.value = value
    }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor( selected ? .orange : .clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 4.0)
                }
            
            Text("\(value)")
                .font(.title)
                .bold()
        }
        .frame(height: 80)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    @StateObject static var problemSetConfiguration: ProblemSetConfiguration = ProblemSetConfiguration(problemType: .addition,
                                                                                                    problemCount: 30,
                                                                                                    valueRange: 1...12,
                                                                                                    selectedValues: [],
                                                                                                    randomize: true)
    
    @State static var showSheet = true
    
    
    static var previews: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.green)
                .sheet(isPresented: $showSheet) {
                    ProblemsConfigView()
                }
                .environmentObject(problemSetConfiguration)
        }
        
    }
}


//#Preview {
//    @StateObject var problemSetConfiguration: ProblemSetConfiguration? = ProblemSetConfiguration(problemType: .addition,
//    @ObservedObject var problemSetConfiguration: ProblemSetConfiguration? = ProblemSetConfiguration(problemType: .addition,
//                                                                                                 problemCount: 20,
//                                                                                                 valueRange: 2...12,
//                                                                                                 selectedValues: [],
//                                                                                                 randomize: true)
    
//    @State var showSheet = true
    
//    return VStack {
//        Rectangle()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(.green)
//            .sheet(isPresented: $showSheet) {
//                    //                ProblemsConfigView(type: .addition, config: $config)
//                ProblemsConfigView()
//            }
//            .environmentObject(problemSetConfiguration)
//    }
//    ProblemsConfigView(type: .addition, config: ProblemSetConfiguration(problemType: .addition, problemCount: 20, valueRange: 2...12, selectedValues: [], randomize: true))
//}
