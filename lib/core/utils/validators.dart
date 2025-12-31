/// Input validators for forms and user input
class Validators {
  Validators._();

  // ============================================================
  // EMAIL VALIDATION
  // ============================================================

  /// Validates email address
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  // ============================================================
  // TEXT VALIDATION
  // ============================================================

  /// Validates required field
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  /// Validates minimum length
  static String? minLength(String? value, int min, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (value.length < min) {
      return '${fieldName ?? 'This field'} must be at least $min characters';
    }

    return null;
  }

  /// Validates maximum length
  static String? maxLength(String? value, int max, [String? fieldName]) {
    if (value != null && value.length > max) {
      return '${fieldName ?? 'This field'} must not exceed $max characters';
    }
    return null;
  }

  /// Validates exact length
  static String? exactLength(String? value, int length, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (value.length != length) {
      return '${fieldName ?? 'This field'} must be exactly $length characters';
    }

    return null;
  }

  // ============================================================
  // NUMBER VALIDATION
  // ============================================================

  /// Validates number
  static String? number(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }

    return null;
  }

  /// Validates integer
  static String? integer(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (int.tryParse(value) == null) {
      return 'Please enter a valid integer';
    }

    return null;
  }

  /// Validates minimum value
  static String? min(String? value, double min, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    final numValue = double.tryParse(value);
    if (numValue == null) {
      return 'Please enter a valid number';
    }

    if (numValue < min) {
      return '${fieldName ?? 'Value'} must be at least $min';
    }

    return null;
  }

  /// Validates maximum value
  static String? max(String? value, double max, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    final numValue = double.tryParse(value);
    if (numValue == null) {
      return 'Please enter a valid number';
    }

    if (numValue > max) {
      return '${fieldName ?? 'Value'} must not exceed $max';
    }

    return null;
  }

  /// Validates range
  static String? range(
    String? value,
    double min,
    double max, [
    String? fieldName,
  ]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    final numValue = double.tryParse(value);
    if (numValue == null) {
      return 'Please enter a valid number';
    }

    if (numValue < min || numValue > max) {
      return '${fieldName ?? 'Value'} must be between $min and $max';
    }

    return null;
  }

  // ============================================================
  // FREQUENCY VALIDATION (for tuner app)
  // ============================================================

  /// Validates frequency input
  static String? frequency(String? value) {
    if (value == null || value.isEmpty) {
      return 'Frequency is required';
    }

    final freq = double.tryParse(value);
    if (freq == null) {
      return 'Please enter a valid frequency';
    }

    if (freq < 20 || freq > 20000) {
      return 'Frequency must be between 20 and 20000 Hz';
    }

    return null;
  }

  /// Validates reference pitch (A4)
  static String? referencePitch(String? value) {
    if (value == null || value.isEmpty) {
      return 'Reference pitch is required';
    }

    final pitch = double.tryParse(value);
    if (pitch == null) {
      return 'Please enter a valid pitch';
    }

    if (pitch < 430 || pitch > 450) {
      return 'Reference pitch must be between 430 and 450 Hz';
    }

    return null;
  }

  // ============================================================
  // PATTERN VALIDATION
  // ============================================================

  /// Validates against a regex pattern
  static String? pattern(String? value, RegExp pattern, String errorMessage) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (!pattern.hasMatch(value)) {
      return errorMessage;
    }

    return null;
  }

  /// Validates alphanumeric
  static String? alphanumeric(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return '${fieldName ?? 'This field'} must contain only letters and numbers';
    }

    return null;
  }

  // ============================================================
  // COMPOSITE VALIDATORS
  // ============================================================

  /// Combines multiple validators
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }

  /// Validates only if condition is true
  static String? Function(String?) when(
    bool condition,
    String? Function(String?) validator,
  ) {
    return (value) {
      if (condition) {
        return validator(value);
      }
      return null;
    };
  }
}
