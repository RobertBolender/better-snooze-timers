import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Better Snooze Timers")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                
                if timerManager.isTimerRunning {
                    TimerView(timerManager: timerManager)
                } else {
                    TimerSetupView(timerManager: timerManager)
                }
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $timerManager.showSnoozeChallenge) {
            SnoozeChallengeView(timerManager: timerManager)
        }
    }
}

struct TimerSetupView: View {
    @ObservedObject var timerManager: TimerManager
    @State private var minutes: Int = 1
    @State private var snoozeDuration: Int = 5
    @State private var snoozeMode: SnoozeDurationMode = .fixed
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Set Timer")
                .font(.title2)
                .bold()
            
            Picker("Minutes", selection: $minutes) {
                ForEach(1..<61) { minute in
                    Text("\(minute) min")
                        .tag(minute)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            
            // Snooze configuration section
            VStack(spacing: 15) {
                Text("Snooze Settings")
                    .font(.headline)
                
                HStack {
                    Text("Initial Snooze Duration:")
                    Spacer()
                    Picker("Snooze", selection: $snoozeDuration) {
                        ForEach([1, 3, 5, 10, 15, 20, 30], id: \.self) { mins in
                            Text("\(mins) min").tag(mins)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Snooze Mode:")
                        .font(.subheadline)
                    
                    Picker("Mode", selection: $snoozeMode) {
                        Text("Fixed Duration").tag(SnoozeDurationMode.fixed)
                        Text("Decreasing Duration").tag(SnoozeDurationMode.decreasing)
                    }
                    .pickerStyle(.segmented)
                    
                    Text(snoozeMode == .fixed 
                        ? "Same duration each snooze"
                        : "Halves each snooze (min: 1 min)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            Button(action: {
                timerManager.startTimer(minutes: minutes, snoozeDuration: snoozeDuration, snoozeMode: snoozeMode)
            }) {
                Text("Start Timer")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}

struct TimerView: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Timer Running")
                .font(.title2)
                .bold()
            
            Text(timerManager.timeRemaining.formatted())
                .font(.system(size: 60, weight: .bold, design: .monospaced))
            
            Button(action: {
                timerManager.stopTimer()
            }) {
                Text("Cancel Timer")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
