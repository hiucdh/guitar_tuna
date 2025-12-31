import '../../core/extensions/double_extension.dart';

import '../entities/note.dart';

/// Use case to find the closest musical note from a frequency
class GetClosestNote {
  /// Executes the use case
  /// [frequency] - input frequency in Hz
  /// Returns a [Note] entity representing the closest note
  Note execute(double frequency) {
    // 1. Calculate MIDI note number (closest integer)
    final midiNumber = frequency.toMidiNote();

    // 2. Get note name and octave from MIDI number
    final name = midiNumber.toNoteName();
    final octave = midiNumber.toOctave();

    // 3. Calculate the exact frequency for this "perfect" note
    // This is the target frequency we want to tune to
    final targetFrequency = midiNumber.toFrequency();

    return Note(
      name: name,
      octave: octave,
      frequency: targetFrequency,
      midiNumber: midiNumber,
    );
  }
}
