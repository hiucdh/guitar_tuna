import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/chord_provider.dart';
import '../../widgets/chords/chord_diagram_widget.dart';
import '../../../core/extensions/context_extension.dart';
import 'chord_detail_screen.dart';
import '../../../domain/entities/chord.dart';

class ChordVariationsScreen extends StatefulWidget {
  final String rootNote; // e.g., "C"

  const ChordVariationsScreen({super.key, required this.rootNote});

  @override
  State<ChordVariationsScreen> createState() => _ChordVariationsScreenState();
}

class _ChordVariationsScreenState extends State<ChordVariationsScreen> {
  
  List<Chord> _getVariations(List<Chord> allChords) {
    return allChords.where((chord) {
      // Logic: Symbol starts with rootNote. 
      // Need to be careful: "A" starts with "A", but "Am" also starts with "A". 
      // "Ab" (A flat) would also start with A but is different.
      // For this simplified data set (A-G), basic startWith is okay.
      // But let's check exact match logic if we had sharps/flats.
      // E.g. Root "A". "Am" -> Yes. "Ab" -> No.
      if (chord.symbol.startsWith(widget.rootNote)) {
        // Exclude flats/sharps if root is natural (e.g. root="A", exclude "Ab")
        if (widget.rootNote.length == 1) {
             // If next char is 'b' or '#', it's not this root.
             if (chord.symbol.length > 1) {
               final secondChar = chord.symbol[1];
               if (secondChar == '#' || secondChar == 'b') return false;
             }
        }
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.rootNote} Chords'),
      ),
      body: Consumer<ChordProvider>(
        builder: (context, provider, child) {
          final variations = _getVariations(provider.chords);

          if (variations.isEmpty) {
             return const Center(child: Text('No variations found.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: variations.length,
            itemBuilder: (context, index) {
              final chord = variations[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChordDetailScreen(chord: chord)),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'chord_${chord.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            chord.symbol,
                            style: context.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                         chord.name, 
                         style: context.textTheme.labelMedium?.copyWith(color: Colors.grey),
                         textAlign: TextAlign.center,
                      ),
                       const SizedBox(height: 8),
                      // Mini Diagram
                      Hero(
                        tag: 'diagram_${chord.id}',
                        child: ChordDiagramWidget(
                          chord: chord,
                          width: 80,
                          height: 100,
                          color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
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
