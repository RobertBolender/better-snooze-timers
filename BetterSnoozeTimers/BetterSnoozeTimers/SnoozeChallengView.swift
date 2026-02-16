import SwiftUI

struct SnoozeChallengView: View {
    @ObservedObject var timerManager: TimerManager
    @Environment(\.dismiss) var dismiss
    
    @State private var startRingIndex: Int = Int.random(in: 0..<9)
    @State private var endRingIndex: Int = Int.random(in: 0..<9)
    @State private var draggedFromRing: Int? = nil
    @State private var currentDragPosition: CGPoint? = nil
    @State private var showSuccess = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    init(timerManager: TimerManager) {
        self.timerManager = timerManager
        // Ensure start and end are different
        var start = Int.random(in: 0..<9)
        var end = Int.random(in: 0..<9)
        while end == start {
            end = Int.random(in: 0..<9)
        }
        _startRingIndex = State(initialValue: start)
        _endRingIndex = State(initialValue: end)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Timer Alert!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Drag from the green ring\nto the red ring to snooze")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.8))
                
                RingGridView(
                    startRingIndex: startRingIndex,
                    endRingIndex: endRingIndex,
                    draggedFromRing: $draggedFromRing,
                    currentDragPosition: $currentDragPosition,
                    onDragComplete: handleDragComplete
                )
                .frame(height: 400)
                
                if showError {
                    Text(errorMessage)
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    timerManager.dismissTimer()
                    dismiss()
                }) {
                    Text("Dismiss (Not Recommended)")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.5))
                        .padding()
                }
            }
            .padding()
            
            if showSuccess {
                Color.green.opacity(0.3)
                    .ignoresSafeArea()
                
                Text("Success! Snoozed for 5 minutes")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
        }
    }
    
    private func handleDragComplete(from: Int, to: Int) {
        if from == startRingIndex && to == endRingIndex {
            // Success!
            showSuccess = true
            showError = false
            
            // Snooze for 5 minutes
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                timerManager.snoozeTimer(minutes: 5)
                dismiss()
            }
        } else {
            // Wrong rings!
            showError = true
            if from != startRingIndex {
                errorMessage = "Wrong start ring! Start from the green ring."
            } else {
                errorMessage = "Wrong end ring! Drag to the red ring."
            }
            
            // Hide error after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                showError = false
            }
        }
    }
}

struct RingGridView: View {
    let startRingIndex: Int
    let endRingIndex: Int
    @Binding var draggedFromRing: Int?
    @Binding var currentDragPosition: CGPoint?
    let onDragComplete: (Int, Int) -> Void
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Grid of rings
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<9) { index in
                        RingView(
                            index: index,
                            isStartRing: index == startRingIndex,
                            isEndRing: index == endRingIndex,
                            isDragging: draggedFromRing == index,
                            draggedFromRing: draggedFromRing,
                            currentDragPosition: currentDragPosition,
                            onDragStart: { ringIndex in
                                draggedFromRing = ringIndex
                            },
                            onDragEnd: { ringIndex, position in
                                // Find which ring we're over
                                if let targetRing = findRingAtPosition(position, in: geometry.size) {
                                    onDragComplete(draggedFromRing ?? -1, targetRing)
                                }
                                draggedFromRing = nil
                                currentDragPosition = nil
                            },
                            onDragChange: { position in
                                currentDragPosition = position
                            }
                        )
                    }
                }
                .padding()
            }
        }
    }
    
    private func findRingAtPosition(_ position: CGPoint, in size: CGSize) -> Int? {
        let padding: CGFloat = 20
        let totalPadding = padding * 4 // 2 on each side horizontally
        let availableWidth = size.width - totalPadding
        let ringSize = availableWidth / 3
        
        let totalVerticalPadding = padding * 4
        let availableHeight = size.height - totalVerticalPadding
        let rowHeight = availableHeight / 3
        
        // Calculate which grid cell the position is in
        let col = Int(position.x / (ringSize + padding))
        let row = Int(position.y / (rowHeight + padding))
        
        if row >= 0 && row < 3 && col >= 0 && col < 3 {
            return row * 3 + col
        }
        return nil
    }
}

struct RingView: View {
    let index: Int
    let isStartRing: Bool
    let isEndRing: Bool
    let isDragging: Bool
    let draggedFromRing: Int?
    let currentDragPosition: CGPoint?
    let onDragStart: (Int) -> Void
    let onDragEnd: (Int, CGPoint) -> Void
    let onDragChange: (CGPoint) -> Void
    
    @State private var longPressActive = false
    @GestureState private var isDetectingLongPress = false
    
    var ringColor: Color {
        if isStartRing {
            return .green
        } else if isEndRing {
            return .red
        } else {
            return .gray
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .strokeBorder(ringColor, lineWidth: 8)
                    .background(
                        Circle()
                            .fill(ringColor.opacity(0.1))
                    )
                    .overlay(
                        Circle()
                            .fill(longPressActive ? ringColor.opacity(0.3) : Color.clear)
                    )
                    .scaleEffect(isDragging ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3), value: isDragging)
                
                if isStartRing {
                    Text("START")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.green)
                }
                
                if isEndRing {
                    Text("END")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.red)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Circle())
            .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                        gestureState = currentState
                    }
                    .onChanged { _ in
                        longPressActive = true
                    }
                    .onEnded { _ in
                        longPressActive = false
                        onDragStart(index)
                    }
                    .simultaneously(with: DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if longPressActive || draggedFromRing == index {
                                // Convert local position to global
                                let globalPosition = CGPoint(
                                    x: geometry.frame(in: .global).minX + value.location.x,
                                    y: geometry.frame(in: .global).minY + value.location.y
                                )
                                onDragChange(globalPosition)
                            }
                        }
                        .onEnded { value in
                            if draggedFromRing == index {
                                let globalPosition = CGPoint(
                                    x: geometry.frame(in: .global).minX + value.location.x,
                                    y: geometry.frame(in: .global).minY + value.location.y
                                )
                                onDragEnd(index, globalPosition)
                                longPressActive = false
                            }
                        }
                    )
            )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    SnoozeChallengView(timerManager: TimerManager())
}
