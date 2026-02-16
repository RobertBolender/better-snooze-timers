import SwiftUI
import Combine

enum SnoozeDurationMode {
    case fixed
    case decreasing
}

class TimerManager: ObservableObject {
    @Published var isTimerRunning = false
    @Published var timeRemaining: TimeInterval = 0
    @Published var showSnoozeChallenge = false
    
    private var timer: Timer?
    private var endTime: Date?
    
    // Snooze configuration
    private var initialSnoozeDuration: Int = 5 // in minutes
    private var snoozeDurationMode: SnoozeDurationMode = .fixed
    private var currentSnoozeDuration: Int = 5
    
    func startTimer(minutes: Int, snoozeDuration: Int = 5, snoozeMode: SnoozeDurationMode = .fixed) {
        let duration = TimeInterval(minutes * 60)
        endTime = Date().addingTimeInterval(duration)
        timeRemaining = duration
        isTimerRunning = true
        
        // Configure snooze settings
        initialSnoozeDuration = snoozeDuration
        snoozeDurationMode = snoozeMode
        currentSnoozeDuration = snoozeDuration
        
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
        currentSnoozeDuration = initialSnoozeDuration
    }
    
    func snoozeTimer() {
        showSnoozeChallenge = false
        
        // Calculate snooze duration based on mode
        let snoozeMins: Int
        switch snoozeDurationMode {
        case .fixed:
            snoozeMins = initialSnoozeDuration
        case .decreasing:
            snoozeMins = max(1, currentSnoozeDuration)
            // Decrease for next time (halve the duration, rounded down, minimum 1)
            currentSnoozeDuration = max(1, snoozeMins / 2)
        }
        
        let duration = TimeInterval(snoozeMins * 60)
        endTime = Date().addingTimeInterval(duration)
        timeRemaining = duration
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func getCurrentSnoozeDuration() -> Int {
        switch snoozeDurationMode {
        case .fixed:
            return initialSnoozeDuration
        case .decreasing:
            return max(1, currentSnoozeDuration)
        }
    }
    
    func dismissTimer() {
        showSnoozeChallenge = false
        stopTimer()
    }
}
