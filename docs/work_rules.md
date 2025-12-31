# Work Rules - Guitar Tuna Project

## 📋 Mục Lục
- [1. Quy Tắc Chung](#1-quy-tắc-chung)
- [2. Coding Standards](#2-coding-standards)
- [3. Git Workflow](#3-git-workflow)
- [4. Code Review](#4-code-review)
- [5. Testing](#5-testing)
- [6. Documentation](#6-documentation)
- [7. Performance](#7-performance)
- [8. Security](#8-security)

---

## 1. Quy Tắc Chung

### 1.1 Nguyên Tắc Phát Triển
- **Clean Code First**: Code phải clean, readable và maintainable
- **SOLID Principles**: Tuân thủ các nguyên tắc SOLID
- **DRY (Don't Repeat Yourself)**: Tránh duplicate code
- **KISS (Keep It Simple, Stupid)**: Giữ code đơn giản, dễ hiểu
- **YAGNI (You Aren't Gonna Need It)**: Chỉ implement những gì cần thiết

### 1.2 Quy Trình Làm Việc
1. **Planning**: Phân tích requirements trước khi code
2. **Design**: Thiết kế architecture và UI/UX
3. **Implementation**: Viết code theo standards
4. **Testing**: Test kỹ trước khi commit
5. **Review**: Code review và refactor
6. **Documentation**: Cập nhật docs

---

## 2. Coding Standards

### 2.1 Dart/Flutter Conventions
```dart
// ✅ ĐÚNG: PascalCase cho class names
class GuitarTuner {}
class AudioProcessor {}

// ✅ ĐÚNG: camelCase cho variables, functions
void processPitchData() {}
final String currentNote = 'A';

// ✅ ĐÚNG: snake_case cho file names
// guitar_tuner_screen.dart
// audio_processor.dart

// ✅ ĐÚNG: SCREAMING_SNAKE_CASE cho constants
const double MAX_FREQUENCY = 1000.0;
const int SAMPLE_RATE = 44100;
```

### 2.2 File Organization
```dart
// Thứ tự import
// 1. Dart core libraries
import 'dart:async';
import 'dart:math';

// 2. Flutter libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Third-party packages
import 'package:provider/provider.dart';
import 'package:fft/fft.dart';

// 4. Local imports
import '../models/note.dart';
import '../services/audio_service.dart';
```

### 2.3 Widget Structure
```dart
class MyWidget extends StatelessWidget {
  // 1. Constructor
  const MyWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  // 2. Properties
  final String title;
  final VoidCallback? onTap;

  // 3. Build method
  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  // 4. Private helper methods
  Widget _buildContent() {
    return Container();
  }
}
```

### 2.4 Naming Conventions

#### Variables & Functions
- **Boolean**: Bắt đầu với `is`, `has`, `can`, `should`
  ```dart
  bool isPlaying = false;
  bool hasPermission = true;
  bool canRecord = false;
  ```

- **Collections**: Dùng số nhiều
  ```dart
  List<Note> notes = [];
  Map<String, double> frequencies = {};
  ```

- **Private members**: Bắt đầu với `_`
  ```dart
  String _privateVariable;
  void _privateMethod() {}
  ```

#### Classes & Files
- **Screens**: Kết thúc với `Screen`
  ```dart
  class TunerScreen extends StatefulWidget {}
  // File: tuner_screen.dart
  ```

- **Widgets**: Mô tả rõ ràng
  ```dart
  class FrequencyMeter extends StatelessWidget {}
  // File: frequency_meter.dart
  ```

- **Services**: Kết thúc với `Service`
  ```dart
  class AudioService {}
  // File: audio_service.dart
  ```

- **Models**: Tên danh từ
  ```dart
  class Note {}
  class Tuning {}
  // Files: note.dart, tuning.dart
  ```

### 2.5 Comments & Documentation
```dart
/// Document public APIs với triple slash
/// 
/// [parameter] - Mô tả parameter
/// Returns: Mô tả return value
/// 
/// Example:
/// ```dart
/// final note = detectNote(frequency);
/// ```
String detectNote(double frequency) {
  // Single line comment cho implementation details
  final noteIndex = _calculateNoteIndex(frequency);
  
  /* 
   * Multi-line comment cho complex logic
   * Giải thích algorithm hoặc business logic phức tạp
   */
  return _noteNames[noteIndex];
}
```

### 2.6 Error Handling
```dart
// ✅ ĐÚNG: Handle errors properly
try {
  await audioService.startRecording();
} on PermissionDeniedException catch (e) {
  _showPermissionDialog();
  logger.error('Permission denied', error: e);
} on AudioException catch (e) {
  _showErrorSnackbar(e.message);
  logger.error('Audio error', error: e);
} catch (e, stackTrace) {
  _showGenericError();
  logger.error('Unexpected error', error: e, stackTrace: stackTrace);
}

// ❌ SAI: Catch all without handling
try {
  await audioService.startRecording();
} catch (e) {
  print(e); // Don't use print in production
}
```

### 2.7 Async/Await
```dart
// ✅ ĐÚNG: Use async/await
Future<void> loadData() async {
  try {
    final data = await repository.fetchData();
    setState(() => _data = data);
  } catch (e) {
    _handleError(e);
  }
}

// ✅ ĐÚNG: Use FutureBuilder for UI
Widget build(BuildContext context) {
  return FutureBuilder<Data>(
    future: _dataFuture,
    builder: (context, snapshot) {
      if (snapshot.hasError) return ErrorWidget(snapshot.error);
      if (!snapshot.hasData) return LoadingWidget();
      return DataWidget(snapshot.data!);
    },
  );
}
```

---

## 3. Git Workflow

### 3.1 Branch Strategy
```
main (production)
  ├── develop (development)
  │   ├── feature/tuner-ui
  │   ├── feature/audio-processing
  │   ├── feature/settings
  │   ├── bugfix/frequency-detection
  │   └── hotfix/crash-on-start
```

### 3.2 Branch Naming
- **Feature**: `feature/short-description`
  - `feature/tuner-ui`
  - `feature/chromatic-tuner`
  
- **Bugfix**: `bugfix/issue-description`
  - `bugfix/frequency-detection`
  - `bugfix/ui-layout`

- **Hotfix**: `hotfix/critical-issue`
  - `hotfix/crash-on-start`
  - `hotfix/permission-error`

### 3.3 Commit Messages
```bash
# Format: <type>(<scope>): <subject>

# Types:
feat: Add new feature
fix: Bug fix
docs: Documentation changes
style: Code style changes (formatting, etc)
refactor: Code refactoring
test: Add or update tests
chore: Build process or auxiliary tool changes
perf: Performance improvements

# Examples:
feat(tuner): Add chromatic tuner mode
fix(audio): Fix frequency detection accuracy
docs(readme): Update installation instructions
refactor(ui): Simplify tuner screen layout
test(audio): Add unit tests for pitch detection
perf(fft): Optimize FFT calculation
```

### 3.4 Commit Best Practices
- Commit nhỏ, tập trung vào một thay đổi
- Commit message rõ ràng, mô tả "what" và "why"
- Test trước khi commit
- Không commit code bị comment out
- Không commit debug code (print statements, etc)

---

## 4. Code Review

### 4.1 Review Checklist
- [ ] Code tuân thủ coding standards
- [ ] Có unit tests và pass
- [ ] Không có hardcoded values
- [ ] Error handling đầy đủ
- [ ] Performance tối ưu
- [ ] UI responsive trên nhiều màn hình
- [ ] Accessibility support
- [ ] Documentation đầy đủ
- [ ] Không có security issues

### 4.2 Review Guidelines
- **Be Constructive**: Đưa ra feedback xây dựng
- **Be Specific**: Chỉ rõ vấn đề và đề xuất giải pháp
- **Be Respectful**: Tôn trọng người viết code
- **Focus on Code**: Review code, không review người

---

## 5. Testing

### 5.1 Test Coverage
- **Unit Tests**: ≥ 80% coverage cho business logic
- **Widget Tests**: Test các widgets quan trọng
- **Integration Tests**: Test user flows chính

### 5.2 Test Structure
```dart
// test/services/audio_service_test.dart
void main() {
  group('AudioService', () {
    late AudioService audioService;
    
    setUp(() {
      audioService = AudioService();
    });
    
    tearDown(() {
      audioService.dispose();
    });
    
    test('should detect correct note from frequency', () {
      // Arrange
      const frequency = 440.0; // A4
      
      // Act
      final note = audioService.detectNote(frequency);
      
      // Assert
      expect(note.name, 'A');
      expect(note.octave, 4);
    });
    
    test('should calculate correct cents offset', () {
      // Arrange
      const frequency = 445.0; // Slightly sharp A4
      
      // Act
      final cents = audioService.calculateCents(frequency, 440.0);
      
      // Assert
      expect(cents, closeTo(19.56, 0.01));
    });
  });
}
```

### 5.3 Testing Best Practices
- Test edge cases và error conditions
- Use mocks cho external dependencies
- Test names mô tả rõ ràng behavior
- Arrange-Act-Assert pattern
- Độc lập giữa các tests

---

## 6. Documentation

### 6.1 Code Documentation
- Public APIs phải có documentation comments
- Complex algorithms cần giải thích
- Business logic cần comment why, không chỉ what

### 6.2 Project Documentation
Maintain các docs sau trong `/docs`:
- **README.md**: Project overview, setup instructions
- **ARCHITECTURE.md**: System architecture
- **API.md**: API documentation (nếu có backend)
- **CHANGELOG.md**: Version history
- **CONTRIBUTING.md**: Contribution guidelines

### 6.3 Documentation Updates
- Update docs khi thay đổi features
- Update README khi thay đổi setup process
- Update CHANGELOG cho mỗi release

---

## 7. Performance

### 7.1 Performance Guidelines
- **Avoid Rebuilds**: Use `const` constructors khi có thể
- **Lazy Loading**: Load data khi cần thiết
- **Optimize Images**: Compress và cache images
- **Efficient Lists**: Use `ListView.builder` cho long lists
- **Debounce/Throttle**: Cho user input và API calls

### 7.2 Performance Monitoring
```dart
// Use Flutter DevTools để monitor:
// - Widget rebuild count
// - Memory usage
// - Frame rendering time
// - Network calls

// Profile mode để test performance
flutter run --profile
```

### 7.3 Audio Processing Performance
- Process audio trong isolate để tránh block UI
- Optimize FFT calculations
- Use appropriate buffer sizes
- Minimize memory allocations trong audio callback

---

## 8. Security

### 8.1 Security Best Practices
- **Never commit**: API keys, passwords, secrets
- **Use**: Environment variables cho sensitive data
- **Validate**: All user inputs
- **Sanitize**: Data trước khi display
- **Use HTTPS**: Cho tất cả network calls

### 8.2 Permissions
- Request permissions khi cần thiết
- Explain why cần permission
- Handle permission denied gracefully
- Check permissions trước khi use

### 8.3 Data Privacy
- Không collect unnecessary data
- Encrypt sensitive data
- Clear cache khi appropriate
- Follow platform privacy guidelines

---

## 9. UI/UX Guidelines

### 9.1 Design Principles
- **Consistency**: Consistent UI across app
- **Feedback**: Visual feedback cho user actions
- **Accessibility**: Support screen readers, large text
- **Responsive**: Work on all screen sizes
- **Performance**: Smooth 60fps animations

### 9.2 Theme & Styling
```dart
// Use theme cho consistent styling
final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16),
  ),
);

// Use theme values trong widgets
Text(
  'Title',
  style: Theme.of(context).textTheme.headlineLarge,
);
```

### 9.3 Responsive Design
```dart
// Use MediaQuery cho responsive layout
final screenWidth = MediaQuery.of(context).size.width;
final isTablet = screenWidth > 600;

// Use LayoutBuilder cho adaptive widgets
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return TabletLayout();
    }
    return MobileLayout();
  },
);
```

---

## 10. Deployment

### 10.1 Pre-Release Checklist
- [ ] All tests pass
- [ ] No debug code
- [ ] Update version number
- [ ] Update CHANGELOG
- [ ] Test on real devices
- [ ] Performance profiling
- [ ] Security audit
- [ ] App store assets ready

### 10.2 Version Numbering
Follow semantic versioning: `MAJOR.MINOR.PATCH+BUILD`
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes
- **BUILD**: Build number (auto-increment)

Example: `1.2.3+45`

---

## 📚 References

### Flutter Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Flutter Best Practices](https://docs.flutter.dev/perf/best-practices)

### Audio Processing
- [Flutter Sound](https://pub.dev/packages/flutter_sound)
- [Audio Processing Basics](https://en.wikipedia.org/wiki/Audio_signal_processing)
- [FFT Algorithm](https://en.wikipedia.org/wiki/Fast_Fourier_transform)

---

**Last Updated**: 2025-12-31
**Version**: 1.0.0
