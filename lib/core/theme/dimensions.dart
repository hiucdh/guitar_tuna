import 'package:flutter/material.dart';

/// App dimensions and spacing
/// Defines consistent spacing, sizing, and layout values
class AppDimensions {
  AppDimensions._();

  // ============================================================
  // SPACING - Based on 4px grid system
  // ============================================================

  /// Extra extra small spacing - 4px
  static const double spaceXXS = 4.0;

  /// Extra small spacing - 8px
  static const double spaceXS = 8.0;

  /// Small spacing - 12px
  static const double spaceS = 12.0;

  /// Medium spacing - 16px
  static const double spaceM = 16.0;

  /// Large spacing - 24px
  static const double spaceL = 24.0;

  /// Extra large spacing - 32px
  static const double spaceXL = 32.0;

  /// Extra extra large spacing - 48px
  static const double spaceXXL = 48.0;

  /// Extra extra extra large spacing - 64px
  static const double spaceXXXL = 64.0;

  // ============================================================
  // PADDING
  // ============================================================

  /// Screen horizontal padding
  static const double screenPaddingH = spaceM;

  /// Screen vertical padding
  static const double screenPaddingV = spaceM;

  /// Card padding
  static const double cardPadding = spaceM;

  /// Button padding horizontal
  static const double buttonPaddingH = spaceL;

  /// Button padding vertical
  static const double buttonPaddingV = spaceS;

  /// List item padding
  static const double listItemPadding = spaceM;

  // ============================================================
  // BORDER RADIUS
  // ============================================================

  /// Extra small border radius - 4px
  static const double radiusXS = 4.0;

  /// Small border radius - 8px
  static const double radiusS = 8.0;

  /// Medium border radius - 12px
  static const double radiusM = 12.0;

  /// Large border radius - 16px
  static const double radiusL = 16.0;

  /// Extra large border radius - 24px
  static const double radiusXL = 24.0;

  /// Circular border radius - 999px
  static const double radiusCircular = 999.0;

  // BorderRadius objects for convenience
  static const BorderRadius borderRadiusXS = BorderRadius.all(
    Radius.circular(radiusXS),
  );
  static const BorderRadius borderRadiusS = BorderRadius.all(
    Radius.circular(radiusS),
  );
  static const BorderRadius borderRadiusM = BorderRadius.all(
    Radius.circular(radiusM),
  );
  static const BorderRadius borderRadiusL = BorderRadius.all(
    Radius.circular(radiusL),
  );
  static const BorderRadius borderRadiusXL = BorderRadius.all(
    Radius.circular(radiusXL),
  );
  static const BorderRadius borderRadiusCircular = BorderRadius.all(
    Radius.circular(radiusCircular),
  );

  // ============================================================
  // ICON SIZES
  // ============================================================

  /// Extra small icon - 16px
  static const double iconXS = 16.0;

  /// Small icon - 20px
  static const double iconS = 20.0;

  /// Medium icon - 24px
  static const double iconM = 24.0;

  /// Large icon - 32px
  static const double iconL = 32.0;

  /// Extra large icon - 48px
  static const double iconXL = 48.0;

  /// Extra extra large icon - 64px
  static const double iconXXL = 64.0;

  // ============================================================
  // BUTTON SIZES
  // ============================================================

  /// Small button height
  static const double buttonHeightS = 36.0;

  /// Medium button height
  static const double buttonHeightM = 48.0;

  /// Large button height
  static const double buttonHeightL = 56.0;

  /// Button minimum width
  static const double buttonMinWidth = 88.0;

  // ============================================================
  // COMPONENT SIZES
  // ============================================================

  /// App bar height
  static const double appBarHeight = 56.0;

  /// Bottom navigation bar height
  static const double bottomNavBarHeight = 64.0;

  /// Tab bar height
  static const double tabBarHeight = 48.0;

  /// List tile height
  static const double listTileHeight = 56.0;

  /// Card elevation
  static const double cardElevation = 2.0;

  /// Dialog elevation
  static const double dialogElevation = 24.0;

  // ============================================================
  // TUNER-SPECIFIC DIMENSIONS
  // ============================================================

  /// Tuner needle size
  static const double tunerNeedleSize = 200.0;

  /// Frequency meter height
  static const double frequencyMeterHeight = 80.0;

  /// Note indicator size
  static const double noteIndicatorSize = 120.0;

  /// String selector item size
  static const double stringSelectorItemSize = 56.0;

  /// Cents display height
  static const double centsDisplayHeight = 60.0;

  /// Waveform visualizer height
  static const double waveformHeight = 100.0;

  /// Spectrum analyzer height
  static const double spectrumHeight = 150.0;

  // ============================================================
  // BORDER WIDTH
  // ============================================================

  /// Thin border - 1px
  static const double borderThin = 1.0;

  /// Medium border - 2px
  static const double borderMedium = 2.0;

  /// Thick border - 3px
  static const double borderThick = 3.0;

  // ============================================================
  // ELEVATION
  // ============================================================

  /// No elevation
  static const double elevationNone = 0.0;

  /// Low elevation
  static const double elevationLow = 2.0;

  /// Medium elevation
  static const double elevationMedium = 4.0;

  /// High elevation
  static const double elevationHigh = 8.0;

  /// Extra high elevation
  static const double elevationXHigh = 16.0;

  // ============================================================
  // OPACITY
  // ============================================================

  /// Disabled opacity
  static const double opacityDisabled = 0.38;

  /// Medium opacity
  static const double opacityMedium = 0.54;

  /// High opacity
  static const double opacityHigh = 0.87;

  /// Full opacity
  static const double opacityFull = 1.0;

  // ============================================================
  // ANIMATION DURATION
  // ============================================================

  /// Fast animation - 150ms
  static const Duration durationFast = Duration(milliseconds: 150);

  /// Normal animation - 300ms
  static const Duration durationNormal = Duration(milliseconds: 300);

  /// Slow animation - 500ms
  static const Duration durationSlow = Duration(milliseconds: 500);

  // ============================================================
  // BREAKPOINTS (for responsive design)
  // ============================================================

  /// Mobile breakpoint
  static const double breakpointMobile = 600.0;

  /// Tablet breakpoint
  static const double breakpointTablet = 900.0;

  /// Desktop breakpoint
  static const double breakpointDesktop = 1200.0;
}
