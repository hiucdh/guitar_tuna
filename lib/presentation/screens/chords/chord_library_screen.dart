import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/chord_provider.dart';
import '../../../core/extensions/context_extension.dart';
import 'chord_variations_screen.dart';

class ChordLibraryScreen extends StatefulWidget {
  const ChordLibraryScreen({super.key});

  @override
  State<ChordLibraryScreen> createState() => _ChordLibraryScreenState();
}

class _ChordLibraryScreenState extends State<ChordLibraryScreen> {
  // Define root notes we want to show categories for
  final List<String> _rootNotes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  @override
  void initState() {
    super.initState();
    // Pre-load chords so they are ready when we go to variations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChordProvider>().loadChords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chord Library'),
      ),
      body: Consumer<ChordProvider>(
        builder: (context, provider, child) {
          // You could show a loading state here if initial load is critical,
          // but since we are just showing static root buttons, we can show them immediately.
          
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns for roots
              childAspectRatio: 1.0,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _rootNotes.length,
            itemBuilder: (context, index) {
              final root = _rootNotes[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // Navigate to variations
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChordVariationsScreen(rootNote: root),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      root,
                      style: context.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
