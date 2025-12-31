import 'dart:math' as math;

/// Double extension methods
extension DoubleExtension on double {
  /// Rounds to specified decimal places
  double roundToDecimal(int places) {
    final mod = math.pow(10.0, places);
    return (this * mod).round() / mod;
  }

  /// Clamps value between min and max
  double clampValue(double min, double max) {
    return clamp(min, max).toDouble();
  }

  /// Checks if value is within range (inclusive)
  bool isInRange(double min, double max) {
    return this >= min && this <= max;
  }

  /// Checks if value is approximately equal to another value
  bool isApproximately(double other, {double epsilon = 0.0001}) {
    return (this - other).abs() < epsilon;
  }

  /// Converts to percentage string
  String toPercentage({int decimals = 0}) {
    return '${(this * 100).roundToDecimal(decimals)}%';
  }

  /// Converts to string with specified decimal places
  String toStringWithDecimals(int decimals) {
    return toStringAsFixed(decimals);
  }

  /// Checks if value is positive
  bool get isPositive => this > 0;

  /// Checks if value is negative
  bool get isNegative => this < 0;

  /// Checks if value is zero (with epsilon tolerance)
  bool get isZero => isApproximately(0.0);

  /// Returns absolute value
  double get absolute => abs();

  /// Converts degrees to radians
  double get toRadians => this * math.pi / 180.0;

  /// Converts radians to degrees
  double get toDegrees => this * 180.0 / math.pi;

  /// Linear interpolation between this and target
  double lerp(double target, double t) {
    return this + (target - this) * t;
  }

  /// Maps value from one range to another
  double mapRange(double fromMin, double fromMax, double toMin, double toMax) {
    return (this - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin;
  }

  /// Converts frequency to MIDI note number
  /// A4 (440 Hz) = MIDI 69
  int toMidiNote({double referenceFrequency = 440.0}) {
    return (12 * (math.log(this / referenceFrequency) / math.log(2)) + 69)
        .round();
  }

  /// Converts cents offset to frequency ratio
  /// 100 cents = 1 semitone
  double centsToRatio() {
    return math.pow(2, this / 1200).toDouble();
  }

  /// Formats as frequency string (Hz)
  String toFrequencyString({int decimals = 2}) {
    return '${roundToDecimal(decimals)} Hz';
  }

  /// Formats as cents string with sign
  String toCentsString({int decimals = 0, bool showSign = true}) {
    final value = roundToDecimal(decimals);
    final sign = showSign && value >= 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(decimals)}¢';
  }
}

/// Int extension methods
extension IntExtension on int {
  /// Converts MIDI note number to frequency
  /// MIDI 69 (A4) = 440 Hz
  double toFrequency({double referenceFrequency = 440.0}) {
    return referenceFrequency * math.pow(2, (this - 69) / 12);
  }

  /// Converts MIDI note number to note name
  String toNoteName() {
    const noteNames = [
      'C',
      'C#',
      'D',
      'D#',
      'E',
      'F',
      'F#',
      'G',
      'G#',
      'A',
      'A#',
      'B',
    ];
    return noteNames[this % 12];
  }

  /// Converts MIDI note number to octave
  int toOctave() {
    return (this / 12).floor() - 1;
  }

  /// Checks if value is within range (inclusive)
  bool isInRange(int min, int max) {
    return this >= min && this <= max;
  }

  /// Checks if value is even
  bool get isEven => this % 2 == 0;

  /// Checks if value is odd
  bool get isOdd => this % 2 != 0;

  /// Clamps value between min and max
  int clampValue(int min, int max) {
    return clamp(min, max).toInt();
  }
}
