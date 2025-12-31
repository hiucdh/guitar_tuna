import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../domain/entities/tuning.dart';
import '../../../domain/repositories/tuning_repository.dart';
import '../../providers/settings_provider.dart';
import '../../providers/tuner_provider.dart';
import '../../../core/theme/colors.dart';

class TuningSelectionScreen extends StatefulWidget {
  const TuningSelectionScreen({super.key});

  @override
  State<TuningSelectionScreen> createState() => _TuningSelectionScreenState();
}

class _TuningSelectionScreenState extends State<TuningSelectionScreen> {
  // We'll load tunings from the repository
  late Future<List<Tuning>> _tuningsFuture;

  @override
  void initState() {
    super.initState();
    _tuningsFuture = _loadTunings();
  }

  Future<List<Tuning>> _loadTunings() async {
    final repo = context.read<TuningRepository>();
    final result = await repo.getAllTunings();
    return result.fold(
      (failure) => [], // Handle error gracefully or show empty
      (tunings) => tunings,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch settings to know current selection
    final settings = context.watch<SettingsProvider>();
    final currentTuningId = settings.selectedTuningId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tuning Selection'),
      ),
      body: FutureBuilder<List<Tuning>>(
        future: _tuningsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Failed to load tunings'));
          }

          final tunings = snapshot.data!;

          return ListView.builder(
            itemCount: tunings.length,
            itemBuilder: (context, index) {
              final tuning = tunings[index];
              final isSelected = tuning.id == currentTuningId;

              return ListTile(
                title: Text(
                  tuning.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.primaryBlue : null,
                  ),
                ),
                subtitle: Text(
                  // Show notes: E A D G B E
                  tuning.notes.join('  '),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: AppColors.primaryBlue)
                    : null,
                onTap: () async {
                  // select tuning in Settings (Persistence)
                  await context.read<SettingsProvider>().setTuning(tuning.id);
                  
                  // Update TunerProvider (Runtime state)
                  if (context.mounted) {
                    context.read<TunerProvider>().setTuning(tuning);
                    context.pop(); // Go back
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
