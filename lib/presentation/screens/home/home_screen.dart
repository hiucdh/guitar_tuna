import 'package:flutter/material.dart';
import '../../../core/extensions/context_extension.dart';
import '../../navigation/routes.dart';

/// Home screen - main landing page
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App logo/title
              Text(
                'Guitar Tuna',
                style: context.textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Professional Guitar Tuner',
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),

              // Start Tuning button
              ElevatedButton.icon(
                onPressed: () => context.pushNamed(Routes.tuner),
                icon: const Icon(Icons.music_note, size: 28),
                label: const Text('Start Tuning'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),

              // Chord Library button
              OutlinedButton.icon(
                onPressed: () => context.pushNamed(Routes.chords),
                icon: const Icon(Icons.library_music),
                label: const Text('Chord Library'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Metronome button
              OutlinedButton.icon(
                onPressed: () => context.pushNamed(Routes.metronome),
                icon: const Icon(Icons.av_timer),
                label: const Text('Metronome'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Settings button
              OutlinedButton.icon(
                onPressed: () => context.pushNamed(Routes.settings),
                icon: const Icon(Icons.settings),
                label: const Text('Settings'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 16),

              // About button
              TextButton.icon(
                onPressed: () => context.pushNamed(Routes.about),
                icon: const Icon(Icons.info_outline),
                label: const Text('About'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
