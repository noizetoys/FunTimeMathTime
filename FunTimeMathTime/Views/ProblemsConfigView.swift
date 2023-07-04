//
//  ProblemsConfigView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI


struct ProblemsConfigView: View {
//    @Environment(QuizEngine.self) private var quizEngine: QuizEngine
    @Environment(\.dismiss) private var dismiss
    
    /// Numbers to use as TOP value
    @State private var allValues: [ValueGridItem] = []
    /// No TOP values selected
    @State private var showAlert: Bool = false
    
    // Used to generate Config
    @State var problemType: ProblemType = .addition
    @State var problemCount: Float = 30
    @State var timeLimit: Float = 3.0
    @State var valueRange: ClosedRange<Int> = 1...12
    @State var selectedValues: [Int] = []
    @State var autoStartQuiz: Bool = false
    @State var randomize: Bool = true
    
    private var timeLimitText: String {
        let limit = timeLimit
        return limit > 0 ? "Time Limit:  \(limit) Minutes" : "No Time Limit"
    }
    private let problemCountRange: ClosedRange<Float> = 20...50
    
    private var columns: [GridItem] = [
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: 10, alignment: .center),
    ]
    
    
        // MARK: - View
    
    @Binding private var paths: [ProblemSetConfiguration]
    
    init(paths: Binding<[ProblemSetConfiguration]>) {
        self._paths = paths
    }
        
    
    var body: some View {
        VStack {
            Text("Quiz Configurator")
                .font(.title)
                .bold()
            
            HStack(spacing: 10) {
                ForEach(ProblemType.allCases, id:\.self) { type in
                    ProblemTypeCell(selectedType: $problemType, type: type)
                        .onTapGesture {
                            problemType = type
                        }
                }
            }
            .padding(.vertical)
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 10, pinnedViews: [], content: {
                ForEach(valueRange, id: \.self) { value in
                    let isSelected = selectedValues.contains(where: { $0 == value })
                    
                    ValueGridItem(selected: isSelected, value: value)
                        .onTapGesture {
                            if selectedValues.contains(value) {
                                selectedValues.append(value)
                            }
                            else {
                                selectedValues.append(value)
                            }
                        }
                        .onLongPressGesture {
                            resetAllValues()
                            selectedValues.append(value)
                        }
                } // For Each
            })
            .padding()
            
            // Sliders, etc.
            VStack {
                VStack {
                    Text("Number of Problems:  \(Int(problemCount))")
                    
                    problemCountSlider
                        .frame(width: 200)
                }
                .padding()
                
                VStack {
                    Text(timeLimitText)
                    
                    timerSlider
                        .frame(width: 200)
                }
                .padding(.top)
            }
            .bold()
            .padding(.vertical)
            
            buttonsRow
//                .padding()
        }
        .alert("No Numbers Selected!", isPresented: $showAlert) {
            Button("Ok", role: .cancel) { }
        }
        .padding()
        .onAppear {
//            resetAllValues()
            print("ProblemsConfigView: 'onAppear' ")
        }
    }
    
    
    /// Resets local values to Defaults
    private func resetAllValues() {
        allValues = []
        
        for value in valueRange {
            allValues.append(ValueGridItem(selected: false, value: value))
        }
        
        problemType = .addition
        problemCount = 30
        timeLimit = 3.0
        valueRange = 1...12
        selectedValues = []
        autoStartQuiz = false
        randomize = true
    }
    
    
    private func createConfig() -> ProblemSetConfiguration {
        let config = ProblemSetConfiguration()
        
        config.problemCount = self.problemCount
        config.timeLimit = self.timeLimit
        config.valueRange = self.valueRange
        config.selectedValues = self.selectedValues
        config.autoStartQuiz = self.autoStartQuiz
        config.randomize = self.randomize
        
        return config
    }
    
    
        // MARK: - Views -
    
    private var problemCountSlider: some View {
        Slider(value: $problemCount,
               in: problemCountRange,
               step: 5,
               label: { Text("Problems") },
               minimumValueLabel: { Text("\(Int(problemCountRange.lowerBound))") },
               maximumValueLabel: { Text("\(Int(problemCountRange.upperBound))") }
        )
    }
    
    
    private var timerSlider: some View {
        Slider(value: $timeLimit,
               in: 0...10,
               step: 0.5,
               label: { Text("Timer") },
               minimumValueLabel: { Text("None") },
               maximumValueLabel: { Text("10") }
        )
    }
    
    
    private var randomizeToggle: some View {
        HStack {
            Toggle(isOn: $randomize) {
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
            cuteButton(title: "Reset", color: .red) {
                resetAllValues()
            }
            
            Spacer()
                .frame(width: 100)
            
                // TODO: Select
            cuteButton(title: "Select", color: .green) {
                guard
                    !selectedValues.isEmpty
                else {
                    showAlert.toggle()
                    return
                }
                
//                withAnimation {
                    paths.append(createConfig())
//                }
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
        .frame(height: 60)
        
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProblemsConfigView()
//    }
//}


//#Preview {
//    ProblemsConfigView()
//}
