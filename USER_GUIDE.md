# User Guide: Better Snooze Timers

## What is Better Snooze Timers?

Better Snooze Timers is an iOS app that makes it nearly impossible to accidentally dismiss important alarms. Unlike standard timer apps where you can easily tap "snooze" while half-asleep, this app requires you to complete a challenging gesture before snoozing.

## How to Use

### Setting a Timer

1. **Open the app** - You'll see the main timer setup screen
2. **Select timer duration** - Use the picker wheel to choose 1-60 minutes
3. **Configure snooze settings**:
   - **Initial Snooze Duration**: Choose from 1, 3, 5, 10, 15, 20, or 30 minutes
   - **Snooze Mode**: Select either:
     - **Fixed Duration**: Same snooze duration every time
     - **Decreasing Duration**: Snooze duration halves each time (minimum 1 minute)
4. **Start timer** - Tap the blue "Start Timer" button
5. **Timer runs** - The countdown displays in large numbers
6. **Cancel anytime** - Tap "Cancel Timer" if you need to stop early

### Snooze Duration Modes

**Fixed Duration Mode:**
- Each snooze will be the same length
- Example: If you set 10 minutes, every snooze will be 10 minutes

**Decreasing Duration Mode:**
- Each snooze is half the previous duration
- Minimum snooze is always 1 minute
- Example: 10 min → 5 min → 2 min → 1 min → 1 min...
- Helps you wake up gradually by making snoozing less attractive

### When the Timer Expires

When your timer goes off, you'll see the **Snooze Challenge Screen**:

- Black background takes over the full screen
- A 3×3 grid of 9 circular rings appears
- One ring is **GREEN** (marked "START")
- One ring is **RED** (marked "END")
- Seven rings are **GRAY** (inactive)

### Completing the Snooze Challenge

The snooze screen will show how many minutes the next snooze will be.

To snooze the timer:

1. **Find the green START ring** - Look carefully at all 9 rings
2. **Long-press the green ring** - Press and hold for at least half a second
3. **Keep holding** - Don't lift your finger!
4. **Drag to the red END ring** - While still holding, move your finger
5. **Release on the red ring** - Let go when your finger is over the red ring
6. **Success!** - If done correctly, you'll see a green success message with the snooze duration

### If You Make a Mistake

The app will show an error message if you:
- Start from the wrong ring (not the green one)
- End on the wrong ring (not the red one)

Just try again! The rings stay in the same positions for each attempt.

### Dismissing the Alarm

If you want to cancel the alarm entirely (not recommended!):
- Look for "Dismiss (Not Recommended)" at the bottom
- Tap to permanently stop the timer

## Why This Design?

### The Problem with Normal Alarms
- Too easy to tap "snooze" without thinking
- Can dismiss important alarms while still groggy
- Muscle memory makes it automatic

### How Better Snooze Timers Helps
- **Requires attention**: You must look at the screen to find the correct rings
- **Prevents autopilot**: Random ring positions change each time
- **Takes time**: Long-press and drag takes several seconds
- **Wakes you up**: The mental task helps you become more alert

## Tips for Best Results

### For Morning Alarms
1. Set your alarm for when you need to wake up
2. Use **Decreasing Duration** mode starting at 10-15 minutes
3. Place phone across the room so you must get up
4. The challenge helps ensure you're actually awake before snoozing
5. Each snooze gets shorter, making it less tempting to keep snoozing

### For Important Reminders
1. Use **Fixed Duration** mode with short intervals (1-3 minutes)
2. The difficulty ensures you won't dismiss by accident
3. Consider setting multiple timers for critical deadlines

### For Medication Reminders
1. Perfect for time-sensitive medications
2. Use **Fixed Duration** with 5-minute snoozes
3. The challenge confirms you're alert enough to take medicine safely
4. Can't accidentally dismiss while distracted

## Customization

### Snooze Configuration

You can customize the snooze behavior for each timer:

**Snooze Duration Options:**
- 1, 3, 5, 10, 15, 20, or 30 minutes

**Snooze Modes:**
- **Fixed**: Always the same duration
- **Decreasing**: Halves each time (min 1 minute)

### Future Customization (Planned)

Future versions may allow you to customize:
- Grid size (2x2, 3x3, 4x4)
- Long press duration
- Additional challenge types

## Troubleshooting

### The gesture isn't working
- Make sure you **long-press first** (hold for 0.5 seconds)
- Keep your finger down the **entire time**
- Don't lift until you're over the correct red ring

### I keep making mistakes
- Take your time - there's no timeout
- Look carefully at all 9 rings first
- Practice with a 1-minute timer to get familiar

### The app closes when I lock my phone
- This is a current limitation
- Keep the app in the foreground while timer runs
- Background notifications coming in future update

## Privacy & Data

- No data is collected or sent anywhere
- No internet connection required
- No accounts or sign-up needed
- Completely private and offline

## System Requirements

- iOS 17.0 or later
- iPhone or iPad
- No special permissions required

## Support

This is an open-source project. For issues, feature requests, or contributions:
- Visit: https://github.com/RobertBolender/better-snooze-timers
- Report bugs in the Issues section
- Contribute via Pull Requests

## Version History

### v1.1.0 (Current)
- Added configurable snooze duration (1-30 minutes)
- Added Fixed and Decreasing snooze modes
- Display current snooze duration on challenge screen

### v1.0.0
- Initial release
- 3×3 ring grid snooze challenge
- Basic timer functionality
- 1-60 minute timer range
- 5-minute fixed snooze duration
