import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/tuner_provider.dart';
import '../../../core/extensions/context_extension.dart';

/// Tuner screen - main tuning interface
class TunerScreen extends StatelessWidget {
  const TunerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tuner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to tuner settings
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          final tuner = context.watch<TunerProvider>();
          
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Detected note display
                Text(
                  tuner.detectedNote ?? '--',
                  style: context.textTheme.displayLarge?.copyWith(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Frequency display
                if (tuner.detectedFrequency != null)
                  Text(
                    '${tuner.detectedFrequency!.toStringAsFixed(2)} Hz',
                    style: context.textTheme.headlineSmall,
                  ),
                const SizedBox(height: 32),

                // Cents display
                Text(
                  tuner.cents >= 0
                      ? '+${tuner.cents.toStringAsFixed(0)}¢'
                      : '${tuner.cents.toStringAsFixed(0)}¢',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: tuner.isInTune
                        ? Colors.green
                        : tuner.cents > 0
                        ? Colors.orange
                        : Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),

                // Tuning status
                Text(tuner.tuningStatus, style: context.textTheme.titleLarge),
                const SizedBox(height: 64),

                // Start/Stop button
                ElevatedButton.icon(
                  onPressed: () {
                    if (tuner.isListening) {
                      tuner.stopListening();
                    } else {
                      tuner.startListening();
                    }
                  },
                  icon: Icon(
                    tuner.isListening ? Icons.stop : Icons.mic,
                    size: 32,
                  ),
                  label: Text(
                    tuner.isListening ? 'Stop' : 'Start',
                    style: const TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
