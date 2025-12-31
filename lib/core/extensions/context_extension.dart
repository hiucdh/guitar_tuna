import 'package:flutter/material.dart';

/// BuildContext extension methods
extension ContextExtension on BuildContext {
  // ============================================================
  // THEME
  // ============================================================

  /// Gets the current theme
  ThemeData get theme => Theme.of(this);

  /// Gets the current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Gets the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Checks if dark mode is enabled
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Checks if light mode is enabled
  bool get isLightMode => theme.brightness == Brightness.light;

  // ============================================================
  // MEDIA QUERY
  // ============================================================

  /// Gets the media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Gets the screen size
  Size get screenSize => mediaQuery.size;

  /// Gets the screen width
  double get screenWidth => screenSize.width;

  /// Gets the screen height
  double get screenHeight => screenSize.height;

  /// Gets the device pixel ratio
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Gets the text scale factor
  double get textScaleFactor => mediaQuery.textScaler.scale(1.0);

  /// Gets the padding (safe area insets)
  EdgeInsets get padding => mediaQuery.padding;

  /// Gets the view insets (keyboard height, etc.)
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Checks if keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  // ============================================================
  // DEVICE TYPE
  // ============================================================

  /// Checks if device is mobile (width < 600)
  bool get isMobile => screenWidth < 600;

  /// Checks if device is tablet (600 <= width < 900)
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;

  /// Checks if device is desktop (width >= 900)
  bool get isDesktop => screenWidth >= 900;

  /// Checks if device is in portrait orientation
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Checks if device is in landscape orientation
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  // ============================================================
  // NAVIGATION
  // ============================================================

  /// Gets the navigator
  NavigatorState get navigator => Navigator.of(this);

  /// Pops the current route
  void pop<T>([T? result]) => navigator.pop(result);

  /// Pushes a new route
  Future<T?> push<T>(Route<T> route) => navigator.push(route);

  /// Pushes a named route
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return navigator.pushNamed(routeName, arguments: arguments);
  }

  /// Pushes a replacement route
  Future<T?> pushReplacement<T, TO>(Route<T> route, {TO? result}) {
    return navigator.pushReplacement(route, result: result);
  }

  /// Pushes a named replacement route
  Future<T?> pushReplacementNamed<T, TO>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigator.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  /// Pops until a predicate is satisfied
  void popUntil(RoutePredicate predicate) {
    navigator.popUntil(predicate);
  }

  /// Checks if can pop
  bool get canPop => navigator.canPop();

  // ============================================================
  // SNACKBAR
  // ============================================================

  /// Shows a snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Shows an error snackbar
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Shows a success snackbar
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ============================================================
  // DIALOG
  // ============================================================

  /// Shows a dialog
  Future<T?> showCustomDialog<T>(Widget dialog) {
    return showDialog<T>(
      context: this,
      builder: (_) => dialog,
    );
  }

  /// Shows an alert dialog
  Future<bool?> showAlertDialog({
    required String title,
    required String message,
    String confirmText = 'OK',
    String? cancelText,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => pop(false),
              child: Text(cancelText),
            ),
          TextButton(
            onPressed: () => pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FOCUS
  // ============================================================

  /// Unfocuses the current focus node (hides keyboard)
  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  /// Requests focus for a focus node
  void requestFocus(FocusNode node) {
    FocusScope.of(this).requestFocus(node);
  }
}
