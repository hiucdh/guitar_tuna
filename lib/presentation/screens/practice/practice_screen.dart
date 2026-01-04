import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/practice_provider.dart';
import '../../../domain/entities/backing_track.dart';
import '../../../core/extensions/context_extension.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PracticeProvider>().init();
    });
  }

  @override
  void dispose() {
    // Optional: Stop playing when leaving screen, or keep playing?
    // User probably wants to practice while looking at other stuff maybe?
    // For now, let's stop to be safe and save resources.
    context.read<PracticeProvider>().stop(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backing Tracks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Consumer<PracticeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.tracks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Icon(Icons.music_off, size: 64, color: Colors.grey),
                   const SizedBox(height: 16),
                   Text(
                     'No backing tracks found.',
                     style: context.textTheme.titleLarge,
                   ),
                   const SizedBox(height: 8),
                   const Text(
                     'Add files to assets/audio/backing_tracks/',
                     style: TextStyle(color: Colors.grey),
                   ),
                ],
              ),
            );
          }

          // Group by Key
          final Map<String, List<BackingTrack>> groupedConfigs = {};
          for (var track in provider.tracks) {
            if (!groupedConfigs.containsKey(track.key)) {
              groupedConfigs[track.key] = [];
            }
            groupedConfigs[track.key]!.add(track);
          }

          return ListView.builder(
            itemCount: groupedConfigs.length + 1, // +1 for padding bottom
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              if (index == groupedConfigs.length) return const SizedBox(height: 100);

              final key = groupedConfigs.keys.elementAt(index);
              final tracks = groupedConfigs[key]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      key,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                  ...tracks.map((track) => _buildTrackTile(context, provider, track)),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<PracticeProvider>(
        builder: (context, provider, child) {
          if (provider.currentTrack == null) return const SizedBox.shrink();

          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.music_note),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          provider.currentTrack!.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                           if (provider.isPlaying) {
                             provider.pause();
                           } else {
                             provider.playTrack(provider.currentTrack!);
                           }
                        },
                        icon: Icon(provider.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                        iconSize: 48,
                        color: context.colorScheme.primary,
                      ),
                    ],
                  ),
                  if (provider.duration.inSeconds > 0)
                    LinearProgressIndicator(
                      value: provider.position.inMilliseconds / provider.duration.inMilliseconds,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrackTile(BuildContext context, PracticeProvider provider, BackingTrack track) {
    final isSelected = provider.currentTrack?.id == track.id;
    final isPlaying = isSelected && provider.isPlaying;

    return Card(
      elevation: isSelected ? 4 : 1,
      surfaceTintColor: isSelected ? context.colorScheme.primary : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isSelected ? context.colorScheme.primary : context.colorScheme.surfaceContainerHighest,
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurfaceVariant,
          ),
        ),
        title: Text(track.title),
        subtitle: Text('Key: ${track.key}'),
        onTap: () {
          provider.playTrack(track);
        },
      ),
    );
  }
}
