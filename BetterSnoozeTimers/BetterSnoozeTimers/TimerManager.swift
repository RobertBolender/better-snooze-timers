import SwiftUI
import Combine

class TimerManager: ObservableObject {
    @Published var isTimerRunning = false
    @Published var timeRemaining: TimeInterval = 0
    @Published var showSnoozeChallenge = false
    
    private var timer: Timer?
    private var endTime: Date?
    
    func startTimer(minutes: Int) {
        let duration = TimeInterval(minutes * 60)
        endTime = Date().addingTimeInterval(duration)
        timeRemaining = duration
        isTimerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func updateTimer() {
        guard let endTime = endTime else { return }
        
        let now = Date()
        timeRemaining = endTime.timeIntervalSince(now)
        
        if timeRemaining <= 0 {
            timerExpired()
        }
    }
    
    private func timerExpired() {
        timer?.invalidate()
        timer = nil
        showSnoozeChallenge = true
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        timeRemaining = 0
        endTime = nil
    }
    
    func snoozeTimer(minutes: Int) {
        showSnoozeChallenge = false
        let duration = TimeInterval(minutes * 60)
        endTime = Date().addingTimeInterval(duration)
        timeRemaining = duration
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func dismissTimer() {
        showSnoozeChallenge = false
        stopTimer()
    }
}
