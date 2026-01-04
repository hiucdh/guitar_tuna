import 'package:flutter/material.dart';
import '../../widgets/chords/chord_diagram_widget.dart';
import '../../../domain/entities/chord.dart';
import '../../../core/extensions/context_extension.dart';

class ChordDetailScreen extends StatelessWidget {
  final Chord chord;

  const ChordDetailScreen({super.key, required this.chord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chord.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Hero(
               tag: 'chord_${chord.id}',
               child: Text(
                chord.symbol,
                style: context.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
               ),
             ),
             const SizedBox(height: 16),
             Text(
               chord.name,
               style: context.textTheme.titleLarge?.copyWith(
                 color: Colors.grey,
               ),
             ),
             const SizedBox(height: 48),
             Hero(
               tag: 'diagram_${chord.id}',
               child: ChordDiagramWidget(
                 chord: chord,
                 width: 250,
                 height: 300,
                 color: context.colorScheme.onSurface,
               ),
             ),
             const SizedBox(height: 32),
             // Future improvement: Play sound button here
          ],
        ),
      ),
    );
  }
}
