import 'package:flutter/material.dart';
import '../../../domain/entities/chord.dart';
import '../../../core/theme/colors.dart'; // Ensure this exists or use colors directly

class ChordDiagramWidget extends StatelessWidget {
  final Chord chord;
  final double width;
  final double height;
  final Color color;

  const ChordDiagramWidget({
    super.key,
    required this.chord,
    this.width = 150,
    this.height = 180,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _ChordPainter(
        fingering: chord.fingering,
        startFret: chord.startFret,
        color: color,
        // Check if context has dark mode if you want dynamic colors
        // For now parameter color is used
      ),
    );
  }
}

class _ChordPainter extends CustomPainter {
  final String fingering; // "x02220"
  final int startFret;
  final Color color;

  _ChordPainter({
    required this.fingering,
    required this.startFret,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Margins
    const topMargin = 0.20; // 20% for X/O and fret number
    const sideMargin = 0.15;

    final drawWidth = size.width * (1 - 2 * sideMargin);
    final drawHeight = size.height * (1 - topMargin - 0.05);
    final topY = size.height * topMargin;

    // 1. Draw 6 vertical strings
    for (int i = 0; i < 6; i++) {
      final x = size.width * sideMargin + (drawWidth / 5) * i;
      canvas.drawLine(
        Offset(x, topY),
        Offset(x, topY + drawHeight),
        paint,
      );
    }

    // 2. Draw 5 horizontal frets (usually show 4-5 frets)
    const numFrets = 5;
    for (int i = 0; i <= numFrets; i++) {
      final y = topY + (drawHeight / numFrets) * i;
      // Make the top nut thicker if startFret is 1
      if (i == 0 && startFret == 1) {
        paint.strokeWidth = 4.0;
        canvas.drawLine(
          Offset(size.width * sideMargin, y),
          Offset(size.width * (1 - sideMargin), y),
          paint,
        );
        paint.strokeWidth = 2.0;
      } else {
        canvas.drawLine(
          Offset(size.width * sideMargin, y),
          Offset(size.width * (1 - sideMargin), y),
          paint,
        );
      }
    }

    // 3. Draw Fingering Dots and X/O
    if (fingering.length == 6) {
      for (int i = 0; i < 6; i++) {
        final char = fingering[i];
        final stringX = size.width * sideMargin + (drawWidth / 5) * i;

        if (char == 'x' || char == 'X') {
          // Draw X above the nut
          _drawText(canvas, '✕', stringX, topY * 0.5, fontHeight: topY * 0.6);
        } else if (char == '0') {
          // Draw O above the nut
          _drawText(canvas, '○', stringX, topY * 0.5, fontHeight: topY * 0.6);
        } else {
          // Parse fret number (1-9)
          final fret = int.tryParse(char);
          if (fret != null) {
            // Calculate relative fret position
            // e.g. if startFret is 1, fret 1 is the first block.
            // if startFret is 3, fret 3 is the first block.
            // But usually 'fingering' numbers are absolute fret numbers relative to nut if Open.
            // However, typically fingering strings for these charts are relative to the nut, 
            // OR relative to the diagram if startFret > 1. 
            // Let's assume the digit represents the offset from the NUT (0 is open).
            // But if we have startFret=3 (barre), the internal 'fingering' usually says where fingers go.
            // Wait, for standard notation "x02220" A major, 2 means 2nd fret of guitar.
            // If startFret is 1 (default), then 2nd fret is in the 2nd slot.
            // If startFret is 3 (e.g. C shape barre at 3rd fret -> Eb), fingering might be generic.
            // Let's stick to standard input: char is absolute fret number.
            // We verify if `fret` is within the range [startFret, startFret + numFrets - 1]
            
            // Adjust logic: If we simply assume the diagram shows frets [startFret ... startFret+4]
            // Then the position is (fret - startFret).
             
            final relativeFret = fret - startFret; 
            if (relativeFret >= 0 && relativeFret < numFrets) {
               // Draw Dot centered in the fret space
               final fretCenterY = topY + (drawHeight / numFrets) * relativeFret + (drawHeight / numFrets / 2);
               canvas.drawCircle(Offset(stringX, fretCenterY), size.width * 0.05, fillPaint);
            }
          }
        }
      }
    }

    // 4. Draw Start Fret Number if > 1
    if (startFret > 1) {
      _drawText(
        canvas, 
        '$startFret fr', 
        size.width * sideMargin * 0.4, 
        topY + (drawHeight / numFrets) * 0.5, 
        fontHeight: drawHeight / numFrets * 0.4
      );
    }
  }

  void _drawText(Canvas canvas, String text, double x, double y, {required double fontHeight}) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: fontHeight,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    textPainter.paint(
      canvas, 
      Offset(x - textPainter.width / 2, y - textPainter.height / 2)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
