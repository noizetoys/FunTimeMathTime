//
//  ProblemsConfigView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI


struct ProblemsConfigView: View {
    @Environment(\.dismiss) private var dismiss
    
    /// Numbers to use as TOP value
    @State private var allValues: [ValueGridItem] = []
    /// No TOP values selected
    @State private var showAlert: Bool = false
    
    // Used to generate Config
    @State var problemType: ProblemType = .addition
    @State var problemCount: Float = 20
    @State var timeLimit: Float = 3.0
    @State var valueRange: ClosedRange<Int> = 1...12
    @State var selectedValues: [Int] = []
    @State var autoStartQuiz: Bool = false
    @State var randomize: Bool = true
    
    private var timeLimitText: String {
        let limit = timeLimit
        return limit > 0 ? "Time Limit:  \(limit) Minutes" : "No Time Limit"
    }
    @State var problemCountRange: ClosedRange<Float> = 20...50
    
    private var columns: [GridItem] = [
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: 10, alignment: .center),
    ]
    
    // AppStorage
    
    @AppStorage(SettingsConstants.MINIMUMPROBLEMS) private var defaultMinimumProblems: Int = 5
    @AppStorage(SettingsConstants.MAXIMUMPROBLEMS) private var defaultMaximumProblems: Int = 50
    @AppStorage(SettingsConstants.NUMBEROFPROBLEMS) private var numberOfProblems: Int = 20
    @AppStorage(SettingsConstants.MAXIMUMSOLUTIONS) private var defaultMaximumSolutions: Int = 3
    
    @AppStorage(SettingsConstants.MINIMUMVALUE) private var defaultMinimumValue: Int = 1
    @AppStorage(SettingsConstants.MAXIMUMVALUE) private var defaultMaximumValue: Int = 12
    @AppStorage(SettingsConstants.MULTIPLEPROBLEMTYPES) private var defaultMultipleProblemTypes: Bool = false
    @AppStorage(SettingsConstants.MULTIPLECHOICE) private var defaultMultipleChoice: Bool = true
    @AppStorage(SettingsConstants.RANDOMIZEPROBLEMS) private var defaultRandomizeProblems: Bool = true
    
    @AppStorage(SettingsConstants.MINIMUMTIME) private var defaultMinimumTime: Double = 0.0
    @AppStorage(SettingsConstants.MAXIMUMTIME) private var defaultMaximumTime: Double = 10.0
    @AppStorage(SettingsConstants.AUTOSTARTQUIZ) private var defaultAutoStartQuiz: Bool = true
    
    @AppStorage(SettingsConstants.SHOWSCORE) private var defaultShowScore: Bool = true

    
        // MARK: - View
    
    @Binding private var paths: [ProblemSetConfiguration]
    
    
    init(paths: Binding<[ProblemSetConfiguration]>) {
        self._paths = paths
        
        // Use defaults
//        problemCountRange = Float(defaultMinimumProblems)...Float(defaultMaximumProblems)
//        valueRange = defaultMinimumValue...defaultMaximumValue
//        
        resetAllValues()
    }
        
    
    var body: some View {
        VStack {
            
            HStack(spacing: 10) {
                ForEach(ProblemType.allCases, id:\.self) { type in
                    ProblemTypeCell(selectedType: $problemType, type: type)
                        .onTapGesture {
                            problemType = type
                        }
                }
            }
            .padding(.bottom)
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 10, pinnedViews: [], content: {
                ForEach(valueRange, id: \.self) { value in
                    let isSelected = selectedValues.contains(where: { $0 == value })
                    
                    ValueGridItem(selected: isSelected, value: value)
                        .onTapGesture {
                            if selectedValues.contains(value), let index = selectedValues.firstIndex(of: value) {
                                selectedValues.remove(at: index)
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
            
            // Sliders, etc.
            VStack {
                Section("Number of Problems: \(Int(problemCount))") {
                    problemCountSlider
                }
                .bold()
                .frame(height: 40)
                .padding(.horizontal)
                
                Section("\(timeLimitText)") {
                    timerSlider
                }
                .bold()
                .frame(height: 40)
                .padding(.horizontal)
            }
            
            buttonsRow
                .padding(.top)
        }
        .alert("No Numbers Selected!", isPresented: $showAlert) {
            Button("Ok", role: .cancel) { }
        }
        .padding()
        .onAppear {
            resetAllValues()
        }
        .navigationTitle("Quiz Bits")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    /// Resets local values to Defaults
    private func resetAllValues() {
        allValues = []
        
        for value in valueRange {
            allValues.append(ValueGridItem(selected: false, value: value))
        }
        
        problemType = .addition
        problemCount = Float(numberOfProblems)
        timeLimit = 3.0
        valueRange = defaultMinimumValue...defaultMaximumValue
        selectedValues = []
        autoStartQuiz = defaultAutoStartQuiz
        randomize = defaultRandomizeProblems
        problemCountRange = Float(defaultMinimumProblems)...Float(defaultMaximumProblems)
    }
    
    
    private func createConfig() -> ProblemSetConfiguration {
        let config = ProblemSetConfiguration()
        
        config.problemCount = self.problemCount
        config.timeLimit = self.timeLimit
        config.valueRange = self.valueRange
        config.selectedValues = self.selectedValues
        config.autoStartQuiz = self.autoStartQuiz
        config.randomize = self.randomize
        config.problemType = self.problemType
        
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
               in: Float(defaultMinimumTime)...Float(defaultMaximumTime),
               step: 0.5,
               label: { Text("Timer") },
               minimumValueLabel: { Text("None") },
               maximumValueLabel: { Text("10") }
        )
    }
    
    
//    private var randomizeToggle: some View {
//        HStack {
//            Toggle(isOn: $randomize) {
//                Text("Randomize Order")
//                    .lineLimit(1)
//                    .multilineTextAlignment(.leading)
//                    .font(.title)
//                    .bold()
//            }
//            .frame(width: 350)
//        }
//        .padding()
//    }
    
    
    private var buttonsRow: some View {
        HStack {
            Spacer()
            
                // TODO: HOw to cancel and go back to Problem Type Picker
            cuteButton(title: "Reset", color: .red) {
                resetAllValues()
            }
            
            Spacer()
            
                // TODO: Select
            cuteButton(title: "Select", color: .green) {
                guard
                    !selectedValues.isEmpty
                else {
                    showAlert.toggle()
                    return
                }
                
                withAnimation {
                    paths.append(createConfig())
                }
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
        .frame(maxWidth: 150, maxHeight: 60)
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
                .foregroundColor( selected ? .green.opacity(0.8) : .clear)
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
