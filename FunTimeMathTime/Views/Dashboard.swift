//
//  Dashboard.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/18/23.
//

import SwiftUI

struct Dashboard: View {
    @StateObject var problemSetConfig: ProblemSetConfiguration = ProblemSetConfiguration()
    
    
    var body: some View {
        GeometryReader { geo in
            
            HStack {
                HistoryListView(problemSets: [HistoricalProbSet.sampleHistoricalSet()])
                    .frame(maxWidth: geo.size.width / 4)
                
                ProblemTypePickerView()
            }
            .padding()
            
        } // Geo
        .environmentObject(problemSetConfig)
        
    }
    
}


#Preview {
    Dashboard()
}
