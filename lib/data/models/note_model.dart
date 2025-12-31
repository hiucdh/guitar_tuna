import '../../domain/entities/note.dart';

/// Note data model with JSON serialization
class NoteModel extends Note {
  const NoteModel({
    required super.name,
    required super.octave,
    required super.frequency,
    required super.midiNumber,
  });

  /// Creates a NoteModel from JSON
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      name: json['name'] as String,
      octave: json['octave'] as int,
      frequency: (json['frequency'] as num).toDouble(),
      midiNumber: json['midiNumber'] as int,
    );
  }

  /// Converts NoteModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'octave': octave,
      'frequency': frequency,
      'midiNumber': midiNumber,
    };
  }

  /// Creates a NoteModel from Note entity
  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      name: note.name,
      octave: note.octave,
      frequency: note.frequency,
      midiNumber: note.midiNumber,
    );
  }

  /// Converts to Note entity
  Note toEntity() {
    return Note(
      name: name,
      octave: octave,
      frequency: frequency,
      midiNumber: midiNumber,
    );
  }
}
