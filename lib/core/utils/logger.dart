/// Simple logger utility for debugging and error tracking
class Logger {
  Logger._();

  static const bool _isDebugMode = true; // Set to false in production

  /// Log levels
  static const String _debug = '🐛 DEBUG';
  static const String _info = 'ℹ️ INFO';
  static const String _warning = '⚠️ WARNING';
  static const String _error = '❌ ERROR';
  static const String _success = '✅ SUCCESS';

  /// Logs a debug message
  static void debug(String message, [String? tag]) {
    if (_isDebugMode) {
      _log(_debug, message, tag);
    }
  }

  /// Logs an info message
  static void info(String message, [String? tag]) {
    _log(_info, message, tag);
  }

  /// Logs a warning message
  static void warning(String message, [String? tag]) {
    _log(_warning, message, tag);
  }

  /// Logs an error message
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(_error, message, tag);
    if (error != null) {
      // ignore: avoid_print
      print('  Error: $error');
    }
    if (stackTrace != null && _isDebugMode) {
      // ignore: avoid_print
      print('  StackTrace: $stackTrace');
    }
  }

  /// Logs a success message
  static void success(String message, [String? tag]) {
    _log(_success, message, tag);
  }

  /// Internal log method
  static void _log(String level, String message, [String? tag]) {
    final timestamp = DateTime.now().toIso8601String();
    final tagStr = tag != null ? '[$tag] ' : '';
    // ignore: avoid_print
    print('$timestamp $level $tagStr$message');
  }

  /// Logs a separator line
  static void separator() {
    if (_isDebugMode) {
      // ignore: avoid_print
      print('=' * 80);
    }
  }

  /// Logs a section header
  static void section(String title) {
    if (_isDebugMode) {
      separator();
      // ignore: avoid_print
      print('  $title');
      separator();
    }
  }

  /// Logs an object (pretty print)
  static void object(String name, Object? object) {
    if (_isDebugMode) {
      // ignore: avoid_print
      print('📦 $name: $object');
    }
  }

  /// Logs a JSON object
  static void json(String name, Map<String, dynamic> json) {
    if (_isDebugMode) {
      // ignore: avoid_print
      print('📄 $name:');
      json.forEach((key, value) {
        // ignore: avoid_print
        print('  $key: $value');
      });
    }
  }

  /// Logs performance timing
  static void timing(String operation, Duration duration) {
    if (_isDebugMode) {
      // ignore: avoid_print
      print('⏱️ $operation took ${duration.inMilliseconds}ms');
    }
  }

  /// Measures and logs execution time of a function
  static Future<T> measure<T>(
    String operation,
    Future<T> Function() function,
  ) async {
    final stopwatch = Stopwatch()..start();
    try {
      final result = await function();
      stopwatch.stop();
      timing(operation, stopwatch.elapsed);
      return result;
    } catch (e) {
      stopwatch.stop();
      error(
        '$operation failed after ${stopwatch.elapsedMilliseconds}ms',
        error: e,
      );
      rethrow;
    }
  }

  /// Measures and logs execution time of a synchronous function
  static T measureSync<T>(String operation, T Function() function) {
    final stopwatch = Stopwatch()..start();
    try {
      final result = function();
      stopwatch.stop();
      timing(operation, stopwatch.elapsed);
      return result;
    } catch (e) {
      stopwatch.stop();
      error(
        '$operation failed after ${stopwatch.elapsedMilliseconds}ms',
        error: e,
      );
      rethrow;
    }
  }
}
