# Better Snooze Timers

A Swift iOS app with custom timers and advanced snooze controls to make it nearly impossible to accidentally dismiss important alarms.

## Features

### Ring Grid Snooze Challenge

The app implements a unique 3x3 grid of rings as a snooze control mechanism:

- **9 Ring Grid**: A 3x3 grid of circular tap targets
- **Long Press & Drag**: Each snooze attempt requires:
  1. Long press (0.5 seconds) on a designated START ring (green)
  2. Hold and drag to a designated END ring (red)
  3. Release on the correct target ring
- **Random Selection**: The start and end rings are randomly selected each time the timer expires
- **Error Feedback**: Visual feedback if wrong rings are used
- **Difficulty**: Makes accidental snoozing nearly impossible

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## Project Structure

```
BetterSnoozeTimers/
├── BetterSnoozeTimersApp.swift    # Main app entry point
├── ContentView.swift               # Main UI with timer setup
├── TimerManager.swift              # Timer state management
├── SnoozeChallengView.swift       # Ring grid snooze challenge UI
└── Assets.xcassets/               # App assets
```

## Usage

1. Open the project in Xcode
2. Select a simulator or device
3. Build and run the app
4. Set a timer duration (1-60 minutes)
5. When the timer expires, complete the snooze challenge by:
   - Long pressing the green START ring
   - Dragging to the red END ring
   - Releasing on the target

## Implementation Details

### RingGridView
- 3x3 grid layout using SwiftUI LazyVGrid
- Each ring is an independent view with gesture recognition
- Rings are colored based on their role (green=start, red=end, gray=inactive)

### Gesture System
- Long press gesture (0.5s minimum) to initiate
- Simultaneous drag gesture to track movement
- Global coordinate tracking to detect ring-to-ring drags
- Visual feedback during interaction

### Timer Management
- ObservableObject-based state management
- Automatic timer expiration detection
- Sheet presentation for snooze challenge
- Configurable snooze duration (default: 5 minutes)

## Future Enhancements

- Additional snooze challenge types
- Customizable difficulty levels
- Timer persistence
- Background notifications
- Multiple simultaneous timers
- Statistics and analytics