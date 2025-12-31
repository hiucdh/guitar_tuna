# Setup Guide - Guitar Tuna

## 📋 Mục Lục
- [System Requirements](#system-requirements)
- [Installation](#installation)
- [Project Setup](#project-setup)
- [Development Environment](#development-environment)
- [Running the App](#running-the-app)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)

---

## System Requirements

### Minimum Requirements
- **Flutter SDK**: 3.9.2 or higher
- **Dart SDK**: 3.9.2 or higher (included with Flutter)
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA

### Platform-Specific Requirements

#### macOS (for iOS development)
- macOS 10.15 (Catalina) or higher
- Xcode 14.0 or higher
- CocoaPods 1.11.0 or higher

#### Windows (for Android development)
- Windows 10 or higher
- Android Studio with Android SDK

#### Linux
- Ubuntu 20.04 LTS or higher
- Android Studio with Android SDK

---

## Installation

### 1. Install Flutter

#### macOS
```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add Flutter to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify installation
flutter doctor
```

#### Windows
1. Download Flutter SDK from [flutter.dev](https://flutter.dev)
2. Extract to `C:\src\flutter`
3. Add `C:\src\flutter\bin` to PATH
4. Run `flutter doctor` in Command Prompt

#### Linux
```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add Flutter to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
flutter doctor
```

### 2. Install Platform Tools

#### For iOS Development (macOS only)
```bash
# Install Xcode from App Store

# Install Xcode Command Line Tools
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# Install CocoaPods
sudo gem install cocoapods

# Accept Xcode license
sudo xcodebuild -license accept
```

#### For Android Development
```bash
# Install Android Studio from https://developer.android.com/studio

# Install Android SDK
# Open Android Studio → SDK Manager → Install:
# - Android SDK Platform (latest)
# - Android SDK Build-Tools
# - Android Emulator
# - Android SDK Platform-Tools

# Accept Android licenses
flutter doctor --android-licenses
```

### 3. Install IDE Extensions

#### VS Code
```bash
# Install Flutter extension
code --install-extension Dart-Code.flutter

# Install Dart extension
code --install-extension Dart-Code.dart-code
```

#### Android Studio
1. Open Android Studio
2. Go to Preferences → Plugins
3. Search and install "Flutter" plugin
4. Restart Android Studio

---

## Project Setup

### 1. Clone Repository
```bash
# Navigate to your projects directory
cd ~/Desktop/mobile

# If starting fresh, the project is already created
cd guitar_tuna
```

### 2. Install Dependencies
```bash
# Get Flutter packages
flutter pub get

# For iOS (macOS only)
cd ios
pod install
cd ..
```

### 3. Configure Project

#### Update `pubspec.yaml`
Ensure all required dependencies are listed:
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  
  # Audio Processing
  flutter_sound: ^9.2.13
  fft: ^2.0.0
  
  # Local Storage
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Permissions
  permission_handler: ^11.1.0
  
  # UI
  flutter_svg: ^2.0.9
  google_fonts: ^6.1.0
  
  # Utils
  equatable: ^2.0.5
  dartz: ^0.10.1
  get_it: ^7.6.4

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  mockito: ^5.4.4
  build_runner: ^2.4.7
```

#### Configure Permissions

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Add permissions -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    
    <application>
        <!-- ... -->
    </application>
</manifest>
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<dict>
    <!-- Add permission descriptions -->
    <key>NSMicrophoneUsageDescription</key>
    <string>Guitar Tuna needs access to your microphone to detect guitar pitch</string>
    
    <!-- ... -->
</dict>
```

---

## Development Environment

### VS Code Configuration

Create `.vscode/settings.json`:
```json
{
  "dart.lineLength": 80,
  "editor.formatOnSave": true,
  "editor.rulers": [80],
  "files.trimTrailingWhitespace": true,
  "dart.debugExternalPackageLibraries": false,
  "dart.debugSdkLibraries": false
}
```

Create `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter (Debug)",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart"
    },
    {
      "name": "Flutter (Profile)",
      "request": "launch",
      "type": "dart",
      "flutterMode": "profile",
      "program": "lib/main.dart"
    },
    {
      "name": "Flutter (Release)",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release",
      "program": "lib/main.dart"
    }
  ]
}
```

### Git Configuration

Create `.gitignore`:
```
# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/
migrate_working_dir/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# Flutter/Dart/Pub related
**/doc/api/
**/ios/Flutter/.last_build_id
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
/build/

# Symbolication related
app.*.symbols

# Obfuscation related
app.*.map.json

# Android Studio will place build artifacts here
/android/app/debug
/android/app/profile
/android/app/release

# iOS/XCode related
**/ios/**/*.mode1v3
**/ios/**/*.mode2v3
**/ios/**/*.moved-aside
**/ios/**/*.pbxuser
**/ios/**/*.perspectivev3
**/ios/**/*sync/
**/ios/**/.sconsign.dblite
**/ios/**/.tags*
**/ios/**/.vagrant/
**/ios/**/DerivedData/
**/ios/**/Icon?
**/ios/**/Pods/
**/ios/**/.symlinks/
**/ios/**/profile
**/ios/**/xcuserdata
**/ios/.generated/
**/ios/Flutter/.last_build_id
**/ios/Flutter/App.framework
**/ios/Flutter/Flutter.framework
**/ios/Flutter/Flutter.podspec
**/ios/Flutter/Generated.xcconfig
**/ios/Flutter/ephemeral
**/ios/Flutter/app.flx
**/ios/Flutter/app.zip
**/ios/Flutter/flutter_assets/
**/ios/Flutter/flutter_export_environment.sh
**/ios/ServiceDefinitions.json
**/ios/Runner/GeneratedPluginRegistrant.*

# Coverage
coverage/

# Exceptions to above rules.
!**/ios/**/default.mode1v3
!**/ios/**/default.mode2v3
!**/ios/**/default.pbxuser
!**/ios/**/default.perspectivev3
```

---

## Running the App

### Check Available Devices
```bash
flutter devices
```

### Run on Different Platforms

#### Chrome (Web)
```bash
flutter run -d chrome
```

#### Android Emulator
```bash
# Start emulator first
flutter emulators --launch <emulator_id>

# Run app
flutter run -d android
```

#### iOS Simulator (macOS only)
```bash
# Start simulator
open -a Simulator

# Run app
flutter run -d ios
```

#### Physical Device
```bash
# Connect device via USB
# Enable USB debugging (Android) or trust computer (iOS)

# Run app
flutter run
```

### Development Modes

#### Debug Mode (default)
```bash
flutter run
```
- Hot reload enabled
- Assertions enabled
- Debug info available
- Slower performance

#### Profile Mode
```bash
flutter run --profile
```
- Performance profiling
- Some optimizations
- No hot reload
- Better performance than debug

#### Release Mode
```bash
flutter run --release
```
- Full optimizations
- No debug info
- Best performance
- No hot reload

---

## Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/unit/services/audio_service_test.dart
```

### Run Tests with Coverage
```bash
# Generate coverage
flutter test --coverage

# View coverage (requires lcov)
# macOS
brew install lcov
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Linux
sudo apt-get install lcov
genhtml coverage/lcov.info -o coverage/html
xdg-open coverage/html/index.html
```

### Run Widget Tests
```bash
flutter test test/widget/
```

### Run Integration Tests
```bash
flutter test integration_test/
```

---

## Building

### Android

#### Debug APK
```bash
flutter build apk --debug
```

#### Release APK
```bash
flutter build apk --release
```

#### App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS (macOS only)

#### Debug Build
```bash
flutter build ios --debug
```

#### Release Build
```bash
flutter build ios --release
```

#### Archive for App Store
```bash
# Open Xcode
open ios/Runner.xcworkspace

# In Xcode: Product → Archive
```

### Web
```bash
flutter build web --release
```

---

## Troubleshooting

### Common Issues

#### 1. "flutter: command not found"
**Solution**: Add Flutter to PATH
```bash
# macOS/Linux
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Windows: Add to System Environment Variables
```

#### 2. "CocoaPods not installed"
**Solution** (macOS):
```bash
sudo gem install cocoapods
```

#### 3. "Android licenses not accepted"
**Solution**:
```bash
flutter doctor --android-licenses
```

#### 4. "Xcode version too old"
**Solution**: Update Xcode from App Store

#### 5. "Gradle build failed"
**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### 6. "Pod install failed"
**Solution**:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

#### 7. "Hot reload not working"
**Solution**:
```bash
# Stop app
# Clean build
flutter clean
flutter pub get

# Run again
flutter run
```

#### 8. "Permission denied" errors
**Solution**:
```bash
# Make sure permissions are configured in:
# - AndroidManifest.xml (Android)
# - Info.plist (iOS)
```

### Debug Tools

#### Flutter DevTools
```bash
# Run app first
flutter run

# In another terminal
flutter pub global activate devtools
flutter pub global run devtools
```

#### Check Flutter Doctor
```bash
flutter doctor -v
```

#### Clean Build
```bash
flutter clean
flutter pub get
```

#### Analyze Code
```bash
flutter analyze
```

---

## Development Workflow

### Daily Workflow
```bash
# 1. Pull latest changes
git pull

# 2. Get dependencies
flutter pub get

# 3. Run app
flutter run

# 4. Make changes
# ... code ...

# 5. Hot reload (press 'r' in terminal)

# 6. Test
flutter test

# 7. Commit
git add .
git commit -m "feat: add feature"
git push
```

### Before Committing
```bash
# 1. Format code
flutter format .

# 2. Analyze code
flutter analyze

# 3. Run tests
flutter test

# 4. Check for issues
flutter doctor
```

---

## Useful Commands

### Flutter Commands
```bash
# Create new Flutter project
flutter create project_name

# Get packages
flutter pub get

# Update packages
flutter pub upgrade

# Run app
flutter run

# Build app
flutter build <platform>

# Test app
flutter test

# Analyze code
flutter analyze

# Format code
flutter format .

# Clean build
flutter clean

# Check Flutter setup
flutter doctor

# List devices
flutter devices

# List emulators
flutter emulators
```

### Git Commands
```bash
# Create new branch
git checkout -b feature/new-feature

# Stage changes
git add .

# Commit changes
git commit -m "commit message"

# Push changes
git push origin feature/new-feature

# Pull changes
git pull

# Merge branch
git merge feature/new-feature

# View status
git status

# View log
git log --oneline
```

---

## Resources

### Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Packages](https://pub.dev/)

### Learning
- [Flutter Codelabs](https://docs.flutter.dev/codelabs)
- [Flutter YouTube Channel](https://www.youtube.com/c/flutterdev)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

### Community
- [Flutter Discord](https://discord.gg/flutter)
- [Flutter Reddit](https://www.reddit.com/r/FlutterDev/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

---

**Last Updated**: 2025-12-31
**Version**: 1.0.0
