import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App text styles
/// Defines typography system using Google Fonts
class AppTextStyles {
  AppTextStyles._();

  // ============================================================
  // FONT FAMILIES
  // ============================================================

  /// Primary font family - Roboto (for body text)
  static String get primaryFont => GoogleFonts.roboto().fontFamily!;

  /// Secondary font family - Montserrat (for headings)
  static String get secondaryFont => GoogleFonts.montserrat().fontFamily!;

  // ============================================================
  // HEADINGS - Using Montserrat
  // ============================================================

  /// Heading 1 - Extra large heading
  /// Usage: Main screen titles
  static TextStyle h1({Color? color}) => GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
    color: color,
  );

  /// Heading 2 - Large heading
  /// Usage: Section titles
  static TextStyle h2({Color? color}) => GoogleFonts.montserrat(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
    letterSpacing: -0.3,
    color: color,
  );

  /// Heading 3 - Medium heading
  /// Usage: Card titles, dialog titles
  static TextStyle h3({Color? color}) => GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0,
    color: color,
  );

  /// Heading 4 - Small heading
  /// Usage: List section headers
  static TextStyle h4({Color? color}) => GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.15,
    color: color,
  );

  /// Heading 5 - Extra small heading
  /// Usage: Subsection titles
  static TextStyle h5({Color? color}) => GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.15,
    color: color,
  );

  /// Heading 6 - Smallest heading
  /// Usage: Small labels, captions
  static TextStyle h6({Color? color}) => GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.15,
    color: color,
  );

  // ============================================================
  // BODY TEXT - Using Roboto
  // ============================================================

  /// Body large - Large body text
  /// Usage: Main content, descriptions
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.5,
    color: color,
  );

  /// Body medium - Medium body text
  /// Usage: Regular content
  static TextStyle bodyMedium({Color? color}) => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.25,
    color: color,
  );

  /// Body small - Small body text
  /// Usage: Secondary content
  static TextStyle bodySmall({Color? color}) => GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.4,
    color: color,
  );

  // ============================================================
  // LABELS
  // ============================================================

  /// Label large - Large label
  /// Usage: Button text, form labels
  static TextStyle labelLarge({Color? color}) => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
    color: color,
  );

  /// Label medium - Medium label
  /// Usage: Chip labels, small buttons
  static TextStyle labelMedium({Color? color}) => GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
    color: color,
  );

  /// Label small - Small label
  /// Usage: Tiny labels, badges
  static TextStyle labelSmall({Color? color}) => GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
    color: color,
  );

  // ============================================================
  // DISPLAY TEXT - Extra large text
  // ============================================================

  /// Display large - Extra large display text
  /// Usage: Hero text, splash screens
  static TextStyle displayLarge({Color? color}) => GoogleFonts.montserrat(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    height: 1.1,
    letterSpacing: -0.25,
    color: color,
  );

  /// Display medium - Large display text
  /// Usage: Feature highlights
  static TextStyle displayMedium({Color? color}) => GoogleFonts.montserrat(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: 0,
    color: color,
  );

  /// Display small - Medium display text
  /// Usage: Emphasized content
  static TextStyle displaySmall({Color? color}) => GoogleFonts.montserrat(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: 0,
    color: color,
  );

  // ============================================================
  // BUTTON TEXT
  // ============================================================

  /// Button text large
  static TextStyle buttonLarge({Color? color}) => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
    color: color,
  );

  /// Button text medium
  static TextStyle buttonMedium({Color? color}) => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
    color: color,
  );

  /// Button text small
  static TextStyle buttonSmall({Color? color}) => GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
    color: color,
  );

  // ============================================================
  // CAPTION & OVERLINE
  // ============================================================

  /// Caption - Small descriptive text
  /// Usage: Helper text, timestamps
  static TextStyle caption({Color? color}) => GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.3,
    letterSpacing: 0.4,
    color: color,
  );

  /// Overline - Uppercase small text
  /// Usage: Category labels, tags
  static TextStyle overline({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.6,
        letterSpacing: 1.5,
        color: color,
      ).copyWith(
        // Force uppercase
        fontFeatures: [const FontFeature.enable('smcp')],
      );

  // ============================================================
  // TUNER-SPECIFIC TEXT STYLES
  // ============================================================

  /// Note name display - Large note letter
  /// Usage: Current note display (A, B, C, etc.)
  static TextStyle noteName({Color? color}) => GoogleFonts.montserrat(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    height: 1.0,
    letterSpacing: -1.0,
    color: color,
  );

  /// Frequency display - Frequency value
  /// Usage: Hz display
  static TextStyle frequency({Color? color}) => GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0,
    fontFeatures: [const FontFeature.tabularFigures()],
    color: color,
  );

  /// Cents display - Cents offset value
  /// Usage: +/- cents display
  static TextStyle cents({Color? color}) => GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: 0,
    fontFeatures: [const FontFeature.tabularFigures()],
    color: color,
  );

  /// String label - Guitar string label
  /// Usage: E, A, D, G, B, E labels
  static TextStyle stringLabel({Color? color}) => GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
    color: color,
  );

  /// Tuning name - Tuning preset name
  /// Usage: Standard, Drop D, etc.
  static TextStyle tuningName({Color? color}) => GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.15,
    color: color,
  );

  // ============================================================
  // MONOSPACE (for technical displays)
  // ============================================================

  /// Monospace text - For technical data
  /// Usage: Debug info, technical values
  static TextStyle monospace({Color? color, double? fontSize}) =>
      GoogleFonts.robotoMono(
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
        letterSpacing: 0,
        color: color,
      );
}
