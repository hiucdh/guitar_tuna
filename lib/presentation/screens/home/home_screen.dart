import 'package:flutter/material.dart';
import '../../../core/extensions/context_extension.dart';
import '../../navigation/routes.dart';
import '../chords/chord_library_screen.dart';
import '../metronome/metronome_screen.dart';
import '../tuner/tuner_screen.dart';
import '../practice/practice_screen.dart';
import '../settings/settings_screen.dart';
import '../about/about_screen.dart';

/// Home screen - main landing page
/// Main Screen with Bottom Navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Ordered: Chord, Metronome, Tuner, Practice, Settings
  int _currentIndex = 2; // Default to Tuner (Center)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          // 0: Chord Library
          ChordLibraryScreen(),
          
          // 1: Metronome
          MetronomeScreen(),
          
          // 2: Tuner (Default)
          TunerScreen(),
          
          // 3: Practice (Backing Tracks)
          PracticeScreen(),

          // 4: About
          AboutScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Chords',
          ),
          NavigationDestination(
            icon: Icon(Icons.av_timer_outlined),
            selectedIcon: Icon(Icons.av_timer),
            label: 'Metronome',
          ),
          NavigationDestination(
            icon: Icon(Icons.mic_none_outlined, size: 32),
            selectedIcon: Icon(Icons.mic_rounded, size: 32),
            label: 'Tuner',
          ),
          NavigationDestination(
            icon: Icon(Icons.playlist_play_outlined),
            selectedIcon: Icon(Icons.playlist_play_rounded),
            label: 'Tracks',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
