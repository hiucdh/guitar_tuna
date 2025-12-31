import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'dimensions.dart';

/// App theme configuration
/// Provides light and dark theme configurations
class AppTheme {
  AppTheme._();

  // ============================================================
  // DARK THEME (Primary)
  // ============================================================

  static ThemeData get darkTheme {
    return ThemeData(
      // Brightness
      brightness: Brightness.dark,

      // Primary color
      primaryColor: AppColors.primaryBlue,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue,
        secondary: AppColors.secondaryCyan,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
        onError: Colors.white,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.darkBackground,

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.darkTextPrimary,
          size: AppDimensions.iconM,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: AppDimensions.elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusM,
        ),
        margin: const EdgeInsets.all(AppDimensions.spaceS),
      ),

      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: AppDimensions.elevationLow,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingH,
            vertical: AppDimensions.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusM,
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingH,
            vertical: AppDimensions.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusM,
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          side: const BorderSide(
            color: AppColors.primaryBlue,
            width: AppDimensions.borderMedium,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingH,
            vertical: AppDimensions.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusM,
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Icon button
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.darkTextPrimary,
          iconSize: AppDimensions.iconM,
        ),
      ),

      // Floating action button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: AppDimensions.elevationMedium,
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.darkBorder,
            width: AppDimensions.borderThin,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.darkBorder,
            width: AppDimensions.borderThin,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: AppDimensions.borderMedium,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppDimensions.borderThin,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppDimensions.borderMedium,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceM,
          vertical: AppDimensions.spaceS,
        ),
        labelStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: AppColors.darkTextSecondary,
        ),
        hintStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: AppColors.darkTextTertiary,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: AppDimensions.borderThin,
        space: AppDimensions.spaceM,
      ),

      // Bottom navigation bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.darkTextSecondary,
        selectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevationMedium,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        elevation: AppDimensions.dialogElevation,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusL,
        ),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        contentTextStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: AppColors.darkTextSecondary,
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurfaceVariant,
        contentTextStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: AppColors.darkTextPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusS,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryBlue;
          }
          return AppColors.darkTextTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryBlue.withValues(alpha: 0.5);
          }
          return AppColors.darkBorder;
        }),
      ),

      // Slider
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primaryBlue,
        inactiveTrackColor: AppColors.darkBorder,
        thumbColor: AppColors.primaryBlue,
        overlayColor: AppColors.overlayLight,
      ),

      // Text theme
      textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.montserrat(
              fontSize: 57,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextPrimary,
            ),
            displayMedium: GoogleFonts.montserrat(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextPrimary,
            ),
            displaySmall: GoogleFonts.montserrat(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextPrimary,
            ),
            headlineLarge: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextPrimary,
            ),
            headlineMedium: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextPrimary,
            ),
            headlineSmall: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextPrimary,
            ),
            titleLarge: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextPrimary,
            ),
            titleMedium: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextPrimary,
            ),
            titleSmall: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextPrimary,
            ),
            bodyLarge: GoogleFonts.roboto(
              fontSize: 16,
              color: AppColors.darkTextPrimary,
            ),
            bodyMedium: GoogleFonts.roboto(
              fontSize: 14,
              color: AppColors.darkTextSecondary,
            ),
            bodySmall: GoogleFonts.roboto(
              fontSize: 12,
              color: AppColors.darkTextTertiary,
            ),
            labelLarge: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.darkTextPrimary,
            ),
            labelMedium: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.darkTextSecondary,
            ),
            labelSmall: GoogleFonts.roboto(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.darkTextTertiary,
            ),
          ),

      // Use Material 3
      useMaterial3: true,
    );
  }

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData get lightTheme {
    return ThemeData(
      // Brightness
      brightness: Brightness.light,

      // Primary color
      primaryColor: AppColors.primaryBlue,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.secondaryCyan,
        surface: AppColors.lightSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
        onError: Colors.white,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.lightBackground,

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.lightTextPrimary,
          size: AppDimensions.iconM,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: AppDimensions.elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusM,
        ),
        margin: const EdgeInsets.all(AppDimensions.spaceS),
      ),

      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: AppDimensions.elevationLow,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingH,
            vertical: AppDimensions.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusM,
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingH,
            vertical: AppDimensions.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusM,
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          side: const BorderSide(
            color: AppColors.primaryBlue,
            width: AppDimensions.borderMedium,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingH,
            vertical: AppDimensions.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusM,
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Icon button
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.lightTextPrimary,
          iconSize: AppDimensions.iconM,
        ),
      ),

      // Floating action button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: AppDimensions.elevationMedium,
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
            width: AppDimensions.borderThin,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
            width: AppDimensions.borderThin,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: AppDimensions.borderMedium,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppDimensions.borderThin,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusM,
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppDimensions.borderMedium,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceM,
          vertical: AppDimensions.spaceS,
        ),
        labelStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: AppColors.lightTextSecondary,
        ),
        hintStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: AppColors.lightTextTertiary,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
        thickness: AppDimensions.borderThin,
        space: AppDimensions.spaceM,
      ),

      // Bottom navigation bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.lightTextSecondary,
        selectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevationMedium,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        elevation: AppDimensions.dialogElevation,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusL,
        ),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        contentTextStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: AppColors.lightTextSecondary,
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightSurfaceVariant,
        contentTextStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: AppColors.lightTextPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusS,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryBlue;
          }
          return AppColors.lightTextTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryBlue.withValues(alpha: 0.5);
          }
          return AppColors.lightBorder;
        }),
      ),

      // Slider
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primaryBlue,
        inactiveTrackColor: AppColors.lightBorder,
        thumbColor: AppColors.primaryBlue,
        overlayColor: AppColors.overlayLight,
      ),

      // Text theme
      textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.montserrat(
              fontSize: 57,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextPrimary,
            ),
            displayMedium: GoogleFonts.montserrat(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextPrimary,
            ),
            displaySmall: GoogleFonts.montserrat(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextPrimary,
            ),
            headlineLarge: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextPrimary,
            ),
            headlineMedium: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextPrimary,
            ),
            headlineSmall: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
            ),
            titleLarge: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
            ),
            titleMedium: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
            ),
            titleSmall: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
            ),
            bodyLarge: GoogleFonts.roboto(
              fontSize: 16,
              color: AppColors.lightTextPrimary,
            ),
            bodyMedium: GoogleFonts.roboto(
              fontSize: 14,
              color: AppColors.lightTextSecondary,
            ),
            bodySmall: GoogleFonts.roboto(
              fontSize: 12,
              color: AppColors.lightTextTertiary,
            ),
            labelLarge: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.lightTextPrimary,
            ),
            labelMedium: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.lightTextSecondary,
            ),
            labelSmall: GoogleFonts.roboto(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.lightTextTertiary,
            ),
          ),

      // Use Material 3
      useMaterial3: true,
    );
  }
}
