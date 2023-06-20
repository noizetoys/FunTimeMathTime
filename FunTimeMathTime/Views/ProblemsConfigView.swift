//
//  ProblemsConfigView.swift
//  MathTime
//
//  Created by Apple User on 6/17/23.
//

import SwiftUI


struct ProblemsConfigView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var allValues: [ValueGridItem] = []
    @State private var selectedValues: Set<Int> = []
    @State private var problemCount: Float = 30
    @State private var timeLimit: Float = 3
    @State private var randomizeOrder: Bool = true
    @State private var showAlert: Bool = false
    
    // Settings:
    // Min & Max
    // Max # of questions
    // Auto Random
    
    private var timeLimitText: String {
        let limit = Int(timeLimit)
        return limit > 0 ? "Time Limit:  \(limit) Minutes" : "No Time Limit"
    }
    
    private let problemType: ProblemType
    
    private let problemRange = 1...12
    private let problemCountRange: ClosedRange<Float> = 20...50
    var problemConfig: Binding<ProblemSetConfiguration?>// = nil
//    @State var problemConfig: ProblemSetConfiguration? // = nil
    
    private var rows: [GridItem] = [
        GridItem(.flexible(minimum: 40, maximum: 100), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 100), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 40, maximum: 100), spacing: 10, alignment: .center),
//        GridItem(.flexible(minimum: 40, maximum: 100), spacing: 10, alignment: .center),
//        GridItem(.flexible(minimum: 40, maximum: 100), spacing: 10, alignment: .center)
    ]
    
    
    // MARK: - Lifecycle
    
    init(type: ProblemType, config: Binding<ProblemSetConfiguration?>) {
        problemType = type
        problemConfig = config
        
        resetAllValues()
    }
    
    
    var body: some View {
        VStack {
            Text("\(problemType.rawValue) Problems")
                .font(.largeTitle)
                .bold()
            
            LazyVGrid(columns: rows, alignment: .center, spacing: 10, pinnedViews: [], content: {
                ForEach(problemRange, id: \.self) { value in
                    let isSelected = selectedValues.contains(where: { $0 == value })
                    ValueGridItem(selected: isSelected, value: value)
                        .onTapGesture {
                            if selectedValues.contains(value) {
                                selectedValues.remove(value)
                            }
                            else {
                                selectedValues.insert(value)
                            }
                        }
                        .onLongPressGesture {
                            resetAllValues()
                            selectedValues.insert(value)
                        }
                } // For Each
                
            })
            
            
            GroupBox {
                
                VStack {
                    Text("Number of Problem:  \(Int(problemCount))")
                    
                    problemCountSlider
                        .padding(.horizontal, 80)
                    
                }
                .font(.title)
                .bold()
                
                Divider()
                
                VStack {
                    Text(timeLimitText)
                    
                    timerSlider
                        .padding(.horizontal, 80)
                    
                }
                .font(.title)
                .bold()
                .padding(.top)
                
//                Divider()
//                
//                HStack {
//                    Toggle(isOn: $randomizeOrder) {
//                        Text("Randomize Order")
//                            .lineLimit(1)
//                            .multilineTextAlignment(.leading)
//                            .font(.title)
//                            .bold()
//                    }
//                    .frame(width: 350)
//                }
//                .padding()
                
            } // Groupbox
            .cornerRadius(15)
            .padding()
            
            buttonsRow
        }
        .alert("No Numbers Selected!", isPresented: $showAlert) {
            Button("Ok", role: .cancel) { }
        }
        .padding()
    }
    
    
    private func resetAllValues() {
        selectedValues = []
        allValues = []
        
        for value in problemRange {
            allValues.append(ValueGridItem(selected: false, value: value))
        }
        
        timeLimit = 3
        randomizeOrder = true
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
        .font(.title)
        .bold()
        
    }
    
    
    private var timerSlider: some View {
        Slider(value: $timeLimit,
               in: 0...10,
               step: 1,
               label: { Text("Timer") },
               minimumValueLabel: { Text("None") },
               maximumValueLabel: { Text("10") }
        )
        .font(.title)
        .bold()
        
    }
    
    
    private var buttonsRow: some View {
        HStack {
            Spacer()
            
                // TODO: HOw to cancel and go back to Problem Type Picker
            cuteButton(title: "Cancel", color: .red) {
                dismiss()
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
                
                let config = ProblemSetConfiguration(problemType: problemType,
                                                     problemCount: Int(problemCount),
                                                     timeLimit: Int(timeLimit),
                                                     valueRange: problemRange,
                                                     selectedValues: Array<Int>(selectedValues),
                                                     randomize: randomizeOrder)
                
                dismiss()
                
                problemConfig.wrappedValue = config
                
                print("\(Int(problemCount)) \(problemType) Selected using \(selectedValues)")
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
        .frame(height: 100)
        
    }
}



#Preview {
    @State var config: ProblemSetConfiguration? = ProblemSetConfiguration(problemType: .addition,
                                                                          problemCount: 20,
                                                                          valueRange: 2...12,
                                                                          selectedValues: [],
                                                                          randomize: true)
    
    return ProblemsConfigView(type: .addition, config: $config)
//    ProblemsConfigView(type: .addition, config: ProblemSetConfiguration(problemType: .addition, problemCount: 20, valueRange: 2...12, selectedValues: [], randomize: true))
}
