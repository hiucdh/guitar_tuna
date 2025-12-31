import 'package:equatable/equatable.dart';

/// Note entity - represents a musical note
class Note extends Equatable {
  /// Note name (C, C#, D, etc.)
  final String name;

  /// Octave number (0-8)
  final int octave;

  /// Frequency in Hz
  final double frequency;

  /// MIDI note number (0-127)
  final int midiNumber;

  const Note({
    required this.name,
    required this.octave,
    required this.frequency,
    required this.midiNumber,
  });

  /// Checks if note is natural (no sharp or flat)
  bool get isNatural => !name.contains('#') && !name.contains('b');

  /// Checks if note is sharp
  bool get isSharp => name.contains('#');

  /// Checks if note is flat
  bool get isFlat => name.contains('b');

  /// Gets full note name with octave (e.g., "A4")
  String get fullName => '$name$octave';

  @override
  List<Object?> get props => [name, octave, frequency, midiNumber];

  @override
  String toString() => fullName;
}
