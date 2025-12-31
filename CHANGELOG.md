# Changelog

All notable changes to Guitar Tuna will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Bass guitar support
- Ukulele support
- Recording feature
- Tuning history
- Metronome integration
- Chord library

---

## [1.0.0] - 2025-12-31

### Added
- 🎯 Initial release of Guitar Tuna
- 🎸 Chromatic tuner with real-time pitch detection
- 🎵 Guitar tuner mode with string selector
- 📊 Frequency spectrum analyzer
- 🎛️ Multiple tuning presets:
  - Standard Tuning (E-A-D-G-B-E)
  - Drop D (D-A-D-G-B-E)
  - Drop C (C-G-C-F-A-D)
  - Open G (D-G-D-G-B-D)
  - DADGAD (D-A-D-G-A-D)
- ⚙️ Settings screen with:
  - Reference pitch adjustment (A4: 430-450Hz)
  - Sensitivity control
  - Theme selection (Light/Dark/Auto)
  - Calibration options
- 🎨 Beautiful UI with:
  - Tuning needle visualization
  - Cents display
  - Audio level meter
  - Waveform visualizer
- 💾 Settings persistence using SharedPreferences
- 🔒 Microphone permission handling
- 📱 Multi-platform support (iOS, Android, Web)
- 🌙 Dark mode support
- ♿ Accessibility features

### Technical
- Clean Architecture implementation
- Provider state management
- FFT-based pitch detection
- Parabolic interpolation for accuracy
- Comprehensive unit tests
- Widget tests for critical components
- Integration tests for main flows
- Complete documentation in `/docs`

---

## Version History

### [1.0.0] - 2025-12-31
- Initial release

---

## Types of Changes

- `Added` for new features
- `Changed` for changes in existing functionality
- `Deprecated` for soon-to-be removed features
- `Removed` for now removed features
- `Fixed` for any bug fixes
- `Security` in case of vulnerabilities

---

**Note**: This changelog is maintained manually. For detailed commit history, see the [Git log](https://github.com/yourusername/guitar_tuna/commits/).
