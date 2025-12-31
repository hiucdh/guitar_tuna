import 'dart:math' as math;

/// Use case for calculating cents offset between two frequencies
class CalculateCents {
  /// Calculates cents offset
  /// Returns positive value if detected frequency is sharp
  /// Returns negative value if detected frequency is flat
  double execute(double detectedFrequency, double targetFrequency) {
    if (targetFrequency <= 0 || detectedFrequency <= 0) {
      return 0.0;
    }

    // Formula: cents = 1200 * log2(f1/f2)
    final ratio = detectedFrequency / targetFrequency;
    final cents = 1200 * (math.log(ratio) / math.ln2);

    return cents;
  }

  /// Checks if frequency is in tune (within threshold)
  bool isInTune(double cents, {double threshold = 5.0}) {
    return cents.abs() <= threshold;
  }
}
