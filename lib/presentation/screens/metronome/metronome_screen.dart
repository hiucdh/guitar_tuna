import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/metronome_provider.dart';
import '../../../core/extensions/context_extension.dart';

class MetronomeScreen extends StatefulWidget {
  const MetronomeScreen({super.key});

  @override
  State<MetronomeScreen> createState() => _MetronomeScreenState();
}

class _MetronomeScreenState extends State<MetronomeScreen> with WidgetsBindingObserver {
  late MetronomeProvider _metronomeProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initialize audio service when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MetronomeProvider>().init();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save reference to provider to avoid unsafe context access in dispose
    _metronomeProvider = context.read<MetronomeProvider>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Stop metronome when leaving the screen
    _metronomeProvider.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _metronomeProvider.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metronome'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Consumer<MetronomeProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Visual Beat Indicator
                // Flashes when currentBeat changes (we can listen to provider)
                // For smoother animation, we might need a separate widget, 
                // but simple opacity change on beat is okay.
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: provider.isPlaying 
                        ? (provider.currentBeat == 1 
                            ? context.colorScheme.primary 
                            : context.colorScheme.primaryContainer)
                        : context.colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                    boxShadow: provider.isPlaying
                        ? [BoxShadow(color: context.colorScheme.primary.withOpacity(0.5), blurRadius: 20, spreadRadius: 5)]
                        : [],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          provider.isPlaying ? '${provider.currentBeat}' : 'Ready',
                          style: context.textTheme.displayMedium?.copyWith(
                            color: provider.isPlaying 
                                ? context.colorScheme.onPrimary 
                                : context.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // BPM Display
                Text(
                  '${provider.bpm}',
                  style: context.textTheme.displayLarge?.copyWith(
                    fontSize: 80, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'BPM',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filledTonal(
                      onPressed: provider.decrementBpm,
                      icon: const Icon(Icons.remove),
                      iconSize: 32,
                    ),
                    Expanded(
                      child: Slider(
                        value: provider.bpm.toDouble(),
                        min: 30,
                        max: 300,
                        divisions: 270,
                        label: provider.bpm.toString(),
                        onChanged: (value) => provider.setBpm(value.round()),
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: provider.incrementBpm,
                      icon: const Icon(Icons.add),
                      iconSize: 32,
                    ),
                  ],
                ),
                
                const Spacer(),
                
                // Play/Stop Button
                SizedBox(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton.large(
                    onPressed: provider.togglePlay,
                    backgroundColor: provider.isPlaying 
                        ? context.colorScheme.error 
                        : context.colorScheme.primary,
                    child: Icon(
                      provider.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                      size: 48,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
