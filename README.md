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
## Automated Build Setup for iPhone Installation

To automatically build the app and install prerelease versions on your iPhone, you can set up GitHub Actions with TestFlight distribution.

### Requirements
- Apple Developer Program membership ($99/year)
- Mac with Xcode for initial setup
- GitHub repository with Actions enabled

### High-Level Process

1. **Create App Store Connect API credentials** for automation
2. **Export your code signing materials** (certificates and profiles)
3. **Add credentials as GitHub secrets** in your repository
4. **Create a GitHub Actions workflow** to build and upload
5. **Install TestFlight** on your iPhone to receive builds

### Detailed Steps

#### Step A: Generate App Store Connect API Key
- Login to appstoreconnect.apple.com
- Go to Users & Access → Integrations → App Store Connect API
- Create new key with "App Manager" access
- Download the .p8 file and note the Key ID and Issuer ID

#### Step B: Export Signing Certificate
Use Keychain Access on your Mac:
- Find your iOS Distribution certificate
- Export as .p12 file with a password
- Convert to base64: `base64 -i cert.p12`

#### Step C: Export Provisioning Profile  
From your Mac:
- Navigate to `~/Library/MobileDevice/Provisioning Profiles/`
- Find your app's profile
- Convert to base64: `base64 -i profile.mobileprovision`

#### Step D: Configure GitHub Secrets
In your GitHub repo go to Settings → Secrets and variables → Actions.
Add these encrypted secrets:
- `APPLE_API_KEY` - base64 encoded .p8 file
- `APPLE_KEY_ID` - API Key ID 
- `APPLE_ISSUER_ID` - API Issuer ID
- `BUILD_CERTIFICATE` - base64 encoded .p12
- `P12_PASSWORD` - certificate password
- `BUILD_PROVISION_PROFILE` - base64 encoded profile
- `KEYCHAIN_PASSWORD` - random password for CI
- `APPLE_TEAM_ID` - from developer.apple.com

#### Step E: Create Workflow
Create `.github/workflows/testflight.yml` that:
- Runs on macOS runner
- Decodes and installs certificates/profiles
- Builds the Xcode project  
- Exports IPA for App Store distribution
- Uploads to TestFlight using altool

Example workflow structure:
```yaml
name: TestFlight Deploy
on: 
  push:
    tags: ['v*']
jobs:
  build:
    runs-on: macos-13
    steps:
      - uses: actions/checkout@v4
      - name: Setup signing
        # Decode secrets and configure keychain
      - name: Build archive
        # xcodebuild archive command
      - name: Export IPA
        # xcodebuild exportArchive  
      - name: Upload to TestFlight
        # xcrun altool upload
```

#### Step F: Installing Builds
After pushing a version tag:
- GitHub Actions builds the app
- App uploads to App Store Connect
- Apple processes the build (10-30 min)
- Open TestFlight app on iPhone
- Install the beta build

### Alternative: Direct IPA Installation
For installations without TestFlight:
- Download IPA from workflow artifacts
- Use Xcode Devices window to install on connected iPhone
- Requires ad-hoc provisioning profile with device UDID

### Finding Required Information

**Team ID**: developer.apple.com/account → Membership → Team ID

**Device UDID**: Connect iPhone to Mac → Finder → Click device → Click text under name to show UDID

**Bundle ID**: Must match between Xcode, App Store Connect, and provisioning profile

### Troubleshooting

- **Certificate errors**: Verify base64 encoding is correct, no line breaks
- **Upload fails**: Check Bundle ID matches, increment build number
- **Not in TestFlight**: Wait for processing, verify tester invitation

### Using Fastlane (Optional)
For easier automation, consider using Fastlane which handles certificates, profiles, and uploads automatically. Install with `gem install fastlane` then run `fastlane init` in your project.
