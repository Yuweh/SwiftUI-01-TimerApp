//
//  ContentView.swift
//  TimerApp01
//
//  Created by yuweh on 01/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var isTimerRunning = false
    @State var timeCount = 0.0
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            Text("\(String(format: "%.1f", self.timeCount))s")
                .font(.system(size: 60))
                .bold()
                .frame(width: 220, height: 220)
                .background(Circle().fill(Color.white).shadow(radius: 10))
                .onReceive(self.timer) { time in
                    if isTimerRunning {
                        timeCount += 0.1
                    }
                }
                .padding()
            
            HStack(spacing: 25) {
                Image(systemName: "gobackward.60")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        self.timeCount -= 1.0 //60 seconds
                    }
                
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                        isTimerRunning = true
                    }
                
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        self.timer.upstream.connect().cancel()
                        isTimerRunning = true
                    }
                
                Image(systemName: "goforward.60")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        self.timeCount += 1.0 //60 seconds
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
