# Guitar Tuna - Professional Guitar Tuner

<div align="center">

![Guitar Tuna Logo](assets/images/logo/logo.png)

**A professional, accurate, and beautiful guitar tuner built with Flutter**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.9.2+-blue.svg)](https://flutter.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-lightgrey.svg)](https://flutter.dev/)

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Usage](#-usage) • [Documentation](#-documentation) • [Contributing](#-contributing)

</div>

---

## 📖 About

**Guitar Tuna** là ứng dụng tuner đàn guitar chuyên nghiệp, được xây dựng với Flutter để mang đến trải nghiệm tuning chính xác và mượt mà trên mọi nền tảng. Ứng dụng sử dụng thuật toán FFT (Fast Fourier Transform) tiên tiến để phát hiện pitch với độ chính xác cao.

### ✨ Highlights

- 🎯 **Độ chính xác cao**: Sử dụng FFT và parabolic interpolation
- 🎨 **Giao diện đẹp mắt**: Modern UI/UX design
- ⚡ **Hiệu suất tốt**: Xử lý real-time mượt mà
- 🌍 **Đa nền tảng**: iOS, Android, Web
- 🎵 **Nhiều tuning modes**: Standard, Drop D, và nhiều hơn nữa
- 🌙 **Dark mode**: Hỗ trợ theme sáng/tối

---

## 🚀 Features

### Core Features
- ✅ **Chromatic Tuner**: Tự động phát hiện note từ mọi nhạc cụ
- ✅ **Guitar Tuner**: Chế độ tuning chuyên dụng cho guitar
- ✅ **Real-time Pitch Detection**: Phát hiện pitch theo thời gian thực
- ✅ **Cents Display**: Hiển thị độ lệch chính xác đến từng cent
- ✅ **Visual Feedback**: Giao diện trực quan với tuning needle

### Tuning Modes
- 🎸 **Standard Tuning** (E-A-D-G-B-E)
- 🎸 **Drop D** (D-A-D-G-B-E)
- 🎸 **Drop C** (C-G-C-F-A-D)
- 🎸 **Open G** (D-G-D-G-B-D)
- 🎸 **DADGAD** (D-A-D-G-A-D)
- 🎸 **Custom Tunings**: Tạo tuning riêng

### 📚 Chord Library
- 🎼 **Comprehensive Database**: 35+ hợp âm phổ biến (A-G, Major, Minor, 7, Maj7, m7)
- 🖼️ **Visual Diagrams**: Biểu đồ thế bấm trực quan, rõ nét
- 🗂️ **Categorized View**: Phân loại theo Tông (Root Note) dễ dàng tra cứu

### Advanced Features
- 🎛️ **Reference Pitch Adjustment**: Điều chỉnh A4 (430-450Hz)
- 📊 **Frequency Spectrum Analyzer**: Hiển thị spectrum
- 🎚️ **Sensitivity Control**: Điều chỉnh độ nhạy
- 🔊 **Audio Level Meter**: Hiển thị mức âm thanh
- 💾 **Settings Persistence**: Lưu cài đặt tự động

---

## 📱 Screenshots

<div align="center">

| Tuner Screen | Settings | Spectrum Analyzer |
|:------------:|:--------:|:-----------------:|
| ![Tuner](docs/screenshots/tuner.png) | ![Settings](docs/screenshots/settings.png) | ![Spectrum](docs/screenshots/spectrum.png) |

</div>

---

## 🛠️ Installation

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- iOS 12.0+ / Android 5.0+ / Modern web browser

### Quick Start

```bash
# Clone repository
git clone https://github.com/yourusername/guitar_tuna.git
cd guitar_tuna

# Install dependencies
flutter pub get

# Run app
flutter run
```

### Platform-Specific Setup

#### iOS
```bash
cd ios
pod install
cd ..
flutter run -d ios
```

#### Android
```bash
flutter run -d android
```

#### Web
```bash
flutter run -d chrome
```

For detailed setup instructions, see [Setup Guide](docs/setup.md).

---

## 📖 Usage

### Basic Tuning

1. **Launch the app** and grant microphone permission
2. **Play a string** on your guitar
3. **Watch the tuning needle** - tune until it's centered
4. **Check the cents display** - aim for 0 cents
5. **Repeat** for all strings

### Tips for Best Results

- 🎤 **Quiet environment**: Minimize background noise
- 📍 **Close to microphone**: Hold guitar near device
- 🎵 **One string at a time**: Mute other strings
- 🔊 **Moderate volume**: Not too soft, not too loud
- 🎸 **Fresh strings**: Old strings may be harder to tune

### Using Chord Library

1. Tap **Chord Library** on the Home screen.
2. Select a **Root Note** (e.g., C).
3. Browse variations (C, Cm, C7, etc.).
4. Tap a chord to view the detailed **Fingering Diagram**.

### Changing Tuning Mode

1. Go to **Settings**.
2. Tap **Tuning Mode**.
3. Select from presets (Standard, Drop D, Open G, etc.).
4. The Tuner will automatically adjust target frequencies.

---

## 🏗️ Architecture

Guitar Tuna được xây dựng theo **Clean Architecture** với các layer rõ ràng:

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (UI, Widgets, State Management)    │
├─────────────────────────────────────┤
│       Domain Layer                  │
│  (Business Logic, Use Cases)        │
├─────────────────────────────────────┤
│        Data Layer                   │
│  (Repositories, Data Sources)       │
├─────────────────────────────────────┤
│      Services Layer                 │
│  (Audio, FFT, Pitch Detection)      │
└─────────────────────────────────────┘
```

### Tech Stack

- **Framework**: Flutter 3.9.2+
- **Language**: Dart 3.9.2+
- **State Management**: Provider
- **Audio Processing**: flutter_sound + FFT
- **Local Storage**: SharedPreferences + Hive
- **Dependency Injection**: get_it
- **Testing**: flutter_test + mockito

For detailed architecture documentation, see [Architecture Guide](docs/architecture.md).

---

## 📚 Documentation

Comprehensive documentation is available in the `/docs` folder:

- 📋 [**Work Rules**](docs/work_rules.md) - Coding standards và quy tắc làm việc
- 🏗️ [**Project Structure**](docs/project_structure.md) - Cấu trúc dự án chi tiết
- 🎯 [**Architecture**](docs/architecture.md) - Kiến trúc hệ thống
- 🛠️ [**Setup Guide**](docs/setup.md) - Hướng dẫn cài đặt và setup

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/unit/services/audio_service_test.dart

# Run integration tests
flutter test integration_test/
```

### Test Coverage Goals
- Unit Tests: ≥ 80%
- Widget Tests: Critical widgets
- Integration Tests: Main user flows

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Follow** the [Work Rules](docs/work_rules.md)
4. **Write** tests for your changes
5. **Commit** your changes (`git commit -m 'feat: add amazing feature'`)
6. **Push** to the branch (`git push origin feature/amazing-feature`)
7. **Open** a Pull Request

### Commit Message Convention

```
<type>(<scope>): <subject>

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Formatting
- refactor: Code refactoring
- test: Tests
- chore: Build/tools
```

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Audio processing algorithms from various open-source projects
- Icons and design inspiration from the community

---

## 📞 Support

If you have any questions or issues:

- 📧 Email: support@guitartuna.com
- 🐛 [Report a bug](https://github.com/yourusername/guitar_tuna/issues)
- 💡 [Request a feature](https://github.com/yourusername/guitar_tuna/issues)
- 💬 [Discussions](https://github.com/yourusername/guitar_tuna/discussions)

---

## 🗺️ Roadmap

### Version 1.0.0 (Current)
- [x] Basic chromatic tuner
- [x] Guitar tuner mode
- [x] Multiple tuning presets
- [x] Settings persistence
- [x] Chord library
- [x] Alternate tunings selection

### Version 1.1.0 (Planned)
- [ ] Bass guitar support
- [ ] Ukulele support
- [ ] Recording feature
- [ ] Tuning history

### Version 2.0.0 (Future)
- [ ] Metronome integration
- [ ] Practice mode
- [ ] Cloud sync

---

## ⭐ Star History

If you find this project useful, please consider giving it a star! ⭐

---

<div align="center">

**Made with ❤️ and Flutter**

[⬆ Back to top](#guitar-tuna---professional-guitar-tuner)

</div>
