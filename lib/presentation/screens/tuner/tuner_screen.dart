import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/tuner_provider.dart';
import '../../../core/extensions/context_extension.dart';
import '../../widgets/tuner/tuner_meter.dart';
import '../../../core/theme/colors.dart';
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
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          final tuner = context.watch<TunerProvider>();
          
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // Current Tuning Name
                if (tuner.selectedTuning != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Chip(
                      label: Text(
                        tuner.selectedTuning!.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: AppColors.primaryBlue.withOpacity(0.2),
                    ),
                  ),

                // Detected note display
                Text(
                  tuner.isListening ? (tuner.detectedNote ?? '') : '',
                  style: context.textTheme.displayLarge?.copyWith(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),


                const SizedBox(height: 16),

                // Tuner Meter
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: tuner.cents),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        TunerMeter(
                          cents: value, 
                          isInTune: tuner.isInTune
                        ),
                        const SizedBox(height: 16),
                        Text(
                          value >= 0
                              ? '+${value.toStringAsFixed(0)}¢'
                              : '${value.toStringAsFixed(0)}¢',
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: tuner.isInTune ? Colors.green : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Tuning status
                Text(tuner.tuningStatus, style: context.textTheme.titleLarge),
                const SizedBox(height: 16),
                
                // Frequency display
                if (tuner.detectedFrequency != null)
                  Text(
                    '${tuner.detectedFrequency!.toStringAsFixed(2)} Hz',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                const SizedBox(height: 24),

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
                    size: 24,
                  ),
                  label: Text(
                    tuner.isListening ? 'Stop' : 'Start',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
            ),
          );
        },
      ),
    );
  }
}
