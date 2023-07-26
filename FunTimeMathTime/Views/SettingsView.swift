//
//  SettingsView.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/19/23.
//

import SwiftUI


fileprivate func values<T: Strideable>(from start: T, to end: T, by step: T) -> [T] {
    var values = [T]()
    
    for val in stride(from: start, to: end, by: step as! T.Stride) {
        values.append(val)
    }
    
    return values
}


struct SettingsConstants {
    private init() {}
    
    static let MINIMUMPROBLEMS = "minimumProblems"
    static let MAXIMUMPROBLEMS = "maximumProblems"
    static let NUMBEROFPROBLEMS = "numberOfProblems"
    static let MAXIMUMSOLUTIONS = "maximumSolutions"
    
    static let MINIMUMVALUE = "minimumValue"
    static let MAXIMUMVALUE = "maximumValue"
    
    static let MULTIPLEPROBLEMTYPES = "multipleProblemTypes"
    static let MULTIPLECHOICE = "multipleChoice"
    static let RANDOMIZEPROBLEMS = "randomizeProblems"
    
    static let MINIMUMTIME = "minimumTime"
    static let MAXIMUMTIME = "maximumTime"
    static let AUTOSTARTQUIZ = "autoStartQuiz"
    
    static let SHOWSCORE = "showScore"
}


struct SettingsView: View {
    @AppStorage(SettingsConstants.MINIMUMPROBLEMS) private var minimumProblems: Int = 5
    @AppStorage(SettingsConstants.MAXIMUMPROBLEMS) private var maximumProblems: Int = 50
    @AppStorage(SettingsConstants.NUMBEROFPROBLEMS) private var numberOfProblems: Int = 20
    @AppStorage(SettingsConstants.MAXIMUMSOLUTIONS) private var maximumSolutions: Int = 3
    
    @AppStorage(SettingsConstants.MINIMUMVALUE) private var minimumValue: Int = 1
    @AppStorage(SettingsConstants.MAXIMUMVALUE) private var maximumValue: Int = 12
    @AppStorage(SettingsConstants.MULTIPLEPROBLEMTYPES) private var multipleProblemTypes: Bool = false
    @AppStorage(SettingsConstants.MULTIPLECHOICE) private var multipleChoice: Bool = true
    @AppStorage(SettingsConstants.RANDOMIZEPROBLEMS) private var randomizeProblems: Bool = true
    
    @AppStorage(SettingsConstants.MINIMUMTIME) private var minimumTime: Double = 0.0
    @AppStorage(SettingsConstants.MAXIMUMTIME) private var maximumTime: Double = 10.0
    @AppStorage(SettingsConstants.AUTOSTARTQUIZ) private var autoStartQuiz: Bool = true
    
    @AppStorage(SettingsConstants.SHOWSCORE) private var showScore: Bool = true
    
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section("Number of Problems") {
                    NumberPicker(binding: $minimumProblems, values: values(from: 5, to: 55, by: 5), text: "Fewest")
                    
                    NumberPicker(binding: $maximumProblems, values: values(from: 10, to: 155, by: 5), text: "Most")
                    
                    NumberPicker(binding: $numberOfProblems, values: values(from: minimumProblems, to: maximumProblems, by: 5), text: "Most")
                    
                    NumberPicker(binding: $maximumSolutions, values: Array<Int>.fromRange(2...6), text: "Number of Solutions")
                }
                
                Section("Problem Numbers Range") {
                    NumberPicker(binding: $minimumValue, values: Array<Int>.fromRange(1...9), text: "Smallest Number")
                    
                    NumberPicker(binding: $maximumValue, values: Array<Int>.fromRange(5...19), text: "Largest Number")
                }
                
                Section("Problems") {
                    SimpleToggle(binding: $multipleProblemTypes, mainText: "Multiple Problem Types", subText: "More than one type of problem per quiz")
                    
                    SimpleToggle(binding: $multipleChoice, mainText: "Multiple Choice", subText: "Select or Enter Answer")
                    
                    SimpleToggle(binding: $randomizeProblems, mainText: "Randomize Problems", subText: "Ascending (1, 2, 3..) or Random")
                }
                
                Section("Timer") {
                    Picker(selection: $minimumTime) {
                        ForEach(values(from: 0.0, to: 5.0, by: 0.5), id: \.self) {
                            Text("\($0, specifier: "%.1f")").tag($0)
                        }
                    } label: {
                        Text("Minimum Time")
                    }
                    
                    Picker(selection: $maximumTime) {
                        ForEach(values(from: 2.0, to: 11.0, by: 0.5), id: \.self) {
                            Text("\($0, specifier: "%.1f")").tag($0)
                        }
                    } label: {
                        Text("Maximum Time")
                    }
                    
                    SimpleToggle(binding: $autoStartQuiz, mainText: "Automatically Start Quiz", subText: nil)
                }
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    
    private func NumberPicker(binding: Binding<Int>, values: [Int], text: String) -> some View {
        Picker(selection: binding) {
            ForEach(values, id: \.self) {
                Text("\($0)").tag($0)
            }
        } label: {
            Text(text)
        }

    }

    
    private func SimpleToggle(binding: Binding<Bool>, mainText: String, subText: String?) -> some View {
        Toggle(isOn: binding) {
            VStack(alignment: .leading) {
                Text(mainText)
                
                if let subText {
                    Text(subText)
                        .font(.caption)
                        .fontWeight(.thin)
                }
            }
        }
    }
    
}


fileprivate extension Array {
    static func fromRange(_ range: ClosedRange<Int>) -> [Int] {
        var array = [Int]()
        
        for val in range {
            array.append(val)
        }
        
        return array
    }
    
}


#Preview {
    SettingsView()
}
