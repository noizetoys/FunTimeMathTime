//
//  CountDownSheet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/22/23.
//

import SwiftUI


struct CountDownSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var time: Int = 3
    
    private var timerMessage: String {
        time > 0 ? "Quiz Begins in \(time)" : "Begin"
    }
    
    
    var body: some View {
        VStack {
            Text(timerMessage)
                .font(.system(size: 48))
                .bold()
                .italic()
                .onReceive(timer) { _ in
                    time > 0 ? time -= 1 : done()
                }
        }
        .onAppear {
            _ = timer.connect()
        }
        .frame(width: 600, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(.pink.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    
    private func done() {
        timer.connect().cancel()
        dismiss()
    }
}


//#Preview {
//    CountDownSheet()
//}
