import 'package:flutter/material.dart';
import 'routes.dart';
import '../screens/home/home_screen.dart';
import '../screens/tuner/tuner_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/about/about_screen.dart';

/// App router configuration
class AppRouter {
  AppRouter._();

  /// Generates routes for the app
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case Routes.tuner:
        return MaterialPageRoute(
          builder: (_) => const TunerScreen(),
          settings: settings,
        );

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );

      case Routes.about:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
    }
  }

  /// Handles unknown routes
  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: Center(child: Text('Route ${settings.name} not found')),
      ),
    );
  }
}
