//
//  CountDownSheet.swift
//  FunTimeMathTime
//
//  Created by Apple User on 6/22/23.
//

import SwiftUI


struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct CountDownSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var time: Int = 3
    
    @Binding var showCountdown: Bool
    var doneAction: () -> Void
    
    
    
    private var timerMessage: String {
        time > 0 ? "\(time)" : "Begin"
    }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.clear)
                .padding(5)

                Text(timerMessage)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.largeTitle)
                    .bold()
                    .italic()
                    .onReceive(timer) { _ in
                        time > 0 ? time -= 1 : done()
                    }
        }
        .background(.gray.opacity(0.2))
        .frame(maxWidth: .infinity)
        .safeAreaPadding(.vertical)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onAppear {
            _ = timer.connect()
        }
    }
    
    
    private func done() {
        withAnimation {
            timer.connect().cancel()
            doneAction()
            
            showCountdown.toggle()
        }
    }
    
}


//#Preview {
//    CountDownSheet()
//}
