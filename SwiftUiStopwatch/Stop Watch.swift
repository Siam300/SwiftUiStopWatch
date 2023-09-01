//
//  Stop Watch.swift
//  SwiftUiStopwatch
//
//  Created by Auto on 8/29/23.
//

import SwiftUI

struct Stop_Watch: View {
    
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var isRunning = false
    @State private var elapsedSeconds = 0.0
    @State private var laps: [Double] = []
    @State private var lapTime = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.purple
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 200)
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        Text(timeString(elapsedSeconds))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    
                    HStack(spacing: 20) {
                        Button(action: startStop) {
                            Text(isRunning ? "Stop" : "Start")
                                .font(.title2)
                        }
                        .padding()
                        .background(isRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        
                        Button(action: lapAction) {
                            Image(systemName: "flag.fill")
                        }
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        
                        Button(action: reset) {
                            Text("Reset")
                                .font(.title2)
                        }
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    }
                    
                    ScrollView {
                        VStack {
                            ForEach(laps.indices, id: \.self) { index in
                                Text("Lap \(index + 1): \(timeString(laps[index]))")
                                    .padding()
                                    .background(Color.white.opacity(0.5))
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }

                }
                .onReceive(timer) { _ in
                    if self.isRunning {
                        self.elapsedSeconds += 0.01
                        self.lapTime += 0.01
                    }
                }
                .navigationTitle("Stop Watch ⏱")
            }
        }
    }
    
    func lapAction() {
        if isRunning {
            let lapTime = elapsedSeconds - laps.reduce(0, +)
            laps.append(lapTime)
        }
    }

    
    func startStop() {
        isRunning.toggle()
    }
    
    func reset() {
        isRunning = false
        elapsedSeconds = 0
        lapTime = 0
        laps.removeAll()
    }
    
    func timeString(_ totalSeconds: Double) -> String {
        let hours = Int(totalSeconds) / 3600
        let minutes = Int(totalSeconds) / 60 % 60
        let seconds = Int(totalSeconds) % 60
        let milliseconds = Int(totalSeconds * 100) % 100
        return String(format: "%02i:%02i:%02i.%02i", hours, minutes, seconds, milliseconds)
    }
    
}
struct Stop_Watch_Previews: PreviewProvider {
    static var previews: some View {
        Stop_Watch()
    }
}
