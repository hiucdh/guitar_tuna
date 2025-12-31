import 'package:equatable/equatable.dart';

/// Tuning entity - represents a guitar tuning preset
class Tuning extends Equatable {
  /// Unique identifier
  final String id;

  /// Tuning name (e.g., "Standard", "Drop D")
  final String name;

  /// Note names for each string (low to high)
  final List<String> notes;

  /// Frequencies for each string in Hz
  final List<double> frequencies;

  /// Description of the tuning
  final String? description;

  /// Whether this is a custom tuning
  final bool isCustom;

  const Tuning({
    required this.id,
    required this.name,
    required this.notes,
    required this.frequencies,
    this.description,
    this.isCustom = false,
  });

  /// Number of strings
  int get stringCount => notes.length;

  /// Checks if this is a standard tuning
  bool get isStandard => id == 'standard';

  @override
  List<Object?> get props => [
        id,
        name,
        notes,
        frequencies,
        description,
        isCustom,
      ];

  @override
  String toString() => name;

  /// Creates a copy with modified fields
  Tuning copyWith({
    String? id,
    String? name,
    List<String>? notes,
    List<double>? frequencies,
    String? description,
    bool? isCustom,
  }) {
    return Tuning(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      frequencies: frequencies ?? this.frequencies,
      description: description ?? this.description,
      isCustom: isCustom ?? this.isCustom,
    );
  }
}
