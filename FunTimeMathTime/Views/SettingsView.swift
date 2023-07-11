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
    
    static let MINIMUMPROBLEMS = "MINIMUMPROBLEMS"
    static let MAXIMUMPROBLEMS = "maximumProblems"
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
    @AppStorage(SettingsConstants.MAXIMUMPROBLEMS) private var maximumProblems: Int = 150
    
    @AppStorage(SettingsConstants.MINIMUMVALUE) private var minimumValue: Int = 1
    @AppStorage(SettingsConstants.MAXIMUMVALUE) private var maximumValue: Int = 19
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
                    Picker(selection: $minimumProblems) {
                        ForEach(values(from: 5, to: 55, by: 5), id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    } label: {
                        Text("Minimum")
                    }
                    
                    Picker(selection: $maximumProblems) {
                        ForEach(values(from: 10, to: 155, by: 5), id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    } label: {
                        Text("Maximum")
                    }
                }
                
                Section("Problem Numbers Range") {
                    Picker(selection: $minimumValue) {
                        ForEach(1...9, id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    } label: {
                        Text("Smallest")
                    }
                    
                    Picker(selection: $maximumValue) {
                        ForEach(5...19, id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    } label: {
                        Text("Largest")
                    }
                    
                }
                
                Section("Problems") {
                    
                    Toggle(isOn: $multipleProblemTypes) {
                        VStack(alignment: .leading) {
                            Text("Multiple Problem Types")
                            Text("More than one type of problem per quiz")
                                .font(.caption)
                                .fontWeight(.thin)
                        }
                    }
                    
                    Toggle(isOn: $multipleChoice) {
                        VStack(alignment: .leading) {
                            Text("Multiple Choice")
                            Text("Select or Enter Answer")
                                .font(.caption)
                                .fontWeight(.thin)
                        }
                    }
                    
                    Toggle(isOn: $randomizeProblems) {
                        VStack(alignment: .leading) {
                            Text("Randomize Problems")
                            Text("Ascending (1, 2, 3..) or Random")
                                .font(.caption)
                                .fontWeight(.thin)
                        }
                    }
                    
                    
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
                    
                    Toggle(isOn: $autoStartQuiz) {
                        VStack(alignment: .leading) {
                            Text("Automatically Start Quiz")
                        }
                    }
                    
                }
                
                
                    //            Button {
                    //                
                    //            } label: {
                    //                HStack {
                    //                    Spacer()
                    //                    Text("Save Settings")
                    //                    Spacer()
                    //                }
                    //            }
                
            }
//            .padding()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
}


#Preview {
    SettingsView()
}
