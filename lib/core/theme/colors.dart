import 'package:flutter/material.dart';

/// App color palette
/// Defines all colors used throughout the app
class AppColors {
  AppColors._();

  // ============================================================
  // PRIMARY COLORS - Blue-Purple Gradient Theme
  // ============================================================

  /// Primary blue color
  static const Color primaryBlue = Color(0xFF2196F3);

  /// Primary purple color
  static const Color primaryPurple = Color(0xFF9C27B0);

  /// Primary gradient colors
  static const List<Color> primaryGradient = [primaryBlue, primaryPurple];

  /// Lighter variant of primary blue
  static const Color primaryBlueLight = Color(0xFF64B5F6);

  /// Darker variant of primary blue
  static const Color primaryBlueDark = Color(0xFF1976D2);

  // ============================================================
  // SECONDARY COLORS
  // ============================================================

  /// Secondary accent color - Cyan
  static const Color secondaryCyan = Color(0xFF00BCD4);

  /// Secondary accent color - Teal
  static const Color secondaryTeal = Color(0xFF009688);

  // ============================================================
  // SEMANTIC COLORS
  // ============================================================

  /// Success color - Green
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  /// Warning color - Orange
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  /// Error color - Red
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);

  /// Info color - Blue
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);

  // ============================================================
  // NEUTRAL COLORS - DARK THEME
  // ============================================================

  /// Background colors for dark theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);

  /// Text colors for dark theme
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextTertiary = Color(0xFF808080);
  static const Color darkTextDisabled = Color(0xFF4D4D4D);

  /// Border colors for dark theme
  static const Color darkBorder = Color(0xFF3D3D3D);
  static const Color darkBorderLight = Color(0xFF2A2A2A);

  /// Divider color for dark theme
  static const Color darkDivider = Color(0xFF2A2A2A);

  // ============================================================
  // NEUTRAL COLORS - LIGHT THEME
  // ============================================================

  /// Background colors for light theme
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightSurfaceVariant = Color(0xFFEEEEEE);

  /// Text colors for light theme
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextTertiary = Color(0xFF9E9E9E);
  static const Color lightTextDisabled = Color(0xFFBDBDBD);

  /// Border colors for light theme
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightBorderLight = Color(0xFFEEEEEE);

  /// Divider color for light theme
  static const Color lightDivider = Color(0xFFE0E0E0);

  // ============================================================
  // SPECIAL COLORS
  // ============================================================

  /// Overlay colors
  static const Color overlayLight = Color(0x1AFFFFFF);
  static const Color overlayMedium = Color(0x33FFFFFF);
  static const Color overlayDark = Color(0x4D000000);

  /// Shadow colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  /// Transparent
  static const Color transparent = Color(0x00000000);

  // ============================================================
  // TUNER-SPECIFIC COLORS
  // ============================================================

  /// Color for in-tune indicator
  static const Color inTune = success;

  /// Color for sharp (too high) indicator
  static const Color sharp = error;

  /// Color for flat (too low) indicator
  static const Color flat = warning;

  static const Color tunerSuccess = inTune;
  static const Color tunerSharp = sharp;
  static const Color tunerFlat = flat;

  /// Frequency meter gradient
  static const List<Color> frequencyGradient = [
    Color(0xFF00BCD4), // Cyan
    Color(0xFF2196F3), // Blue
    Color(0xFF9C27B0), // Purple
  ];

  /// Waveform color
  static const Color waveform = primaryBlue;

  /// Spectrum analyzer gradient
  static const List<Color> spectrumGradient = [
    Color(0xFF4CAF50), // Green
    Color(0xFFFFEB3B), // Yellow
    Color(0xFFFF9800), // Orange
    Color(0xFFF44336), // Red
  ];
}
