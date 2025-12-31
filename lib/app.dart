import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';

/// Main app widget
class GuitarTunaApp extends StatelessWidget {
  const GuitarTunaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title
      title: AppConstants.appName,

      // Debug banner
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Default to dark theme
      // Home
      home: const HomeScreen(),
    );
  }
}

/// Temporary home screen for testing theme
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guitar Tuna')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guitar Tuna',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Professional Guitar Tuner',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: () {}, child: const Text('Start Tuning')),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: () {}, child: const Text('Settings')),
            const SizedBox(height: 16),
            TextButton(onPressed: () {}, child: const Text('About')),
          ],
        ),
      ),
    );
  }
}
