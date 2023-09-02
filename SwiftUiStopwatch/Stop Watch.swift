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
        ZStack {
            VStack {
                Text("Stop Watch ⏱")
                    .font(Font.custom("Hammersmith One", size: 30))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                ZStack {
                    Image("Ellipse 1")
                        .frame(width: 250, height: 250)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat((elapsedSeconds.truncatingRemainder(dividingBy: 60)) / 60))
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 250, height: 250)
                        .rotationEffect(.degrees(-90))
                        .overlay(
                            Circle()
                                .trim(from: 0, to: CGFloat((elapsedSeconds.truncatingRemainder(dividingBy: 60)) / 60))
                                .stroke(Color.white, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                .frame(width: 250, height: 250)
                                .rotationEffect(.degrees(-90))
                                .overlay(
                                    ZStack {
                                        Circle()
                                            .frame(width: 18, height: 18)
                                            .foregroundColor(.black)
                                            .offset(x: 0, y: -125)
                                            .rotationEffect(.degrees(elapsedSeconds.truncatingRemainder(dividingBy: 60) * 6))
                                        
                                        Circle()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.white)
                                            .offset(x: 0, y: -125)
                                            .rotationEffect(.degrees(elapsedSeconds.truncatingRemainder(dividingBy: 60) * 6))
                                    }
                                )
                        )
                    
                    Text(timeString(elapsedSeconds))
                        .font(Font.custom("Happy Monkey", size: 40))
                        .foregroundColor(.white)
                    
                }
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: reset) {
                        Image("fa6-solid:repeat")
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                    Button(action: startStop) {
                        
                        Image(isRunning ? "pause.fill" : "Polygon 1")
                            .renderingMode(.template)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    
                    Button(action: lapAction) {
                        Image(systemName: "flag.fill")
                            .renderingMode(.template)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                }
                .padding()
                .padding(.vertical)
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
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 1, green: 0.09, blue: 0.27))
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
