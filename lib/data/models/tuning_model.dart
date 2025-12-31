import '../../domain/entities/tuning.dart';

/// Tuning data model with JSON serialization
class TuningModel extends Tuning {
  const TuningModel({
    required super.id,
    required super.name,
    required super.notes,
    required super.frequencies,
    super.description,
    super.isCustom,
  });

  /// Creates a TuningModel from JSON
  factory TuningModel.fromJson(Map<String, dynamic> json) {
    return TuningModel(
      id: json['id'] as String,
      name: json['name'] as String,
      notes: (json['notes'] as List<dynamic>).cast<String>(),
      frequencies: (json['frequencies'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      description: json['description'] as String?,
      isCustom: json['isCustom'] as bool? ?? false,
    );
  }

  /// Converts TuningModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'notes': notes,
      'frequencies': frequencies,
      'description': description,
      'isCustom': isCustom,
    };
  }

  /// Creates a TuningModel from Tuning entity
  factory TuningModel.fromEntity(Tuning tuning) {
    return TuningModel(
      id: tuning.id,
      name: tuning.name,
      notes: tuning.notes,
      frequencies: tuning.frequencies,
      description: tuning.description,
      isCustom: tuning.isCustom,
    );
  }

  /// Converts to Tuning entity
  Tuning toEntity() {
    return Tuning(
      id: id,
      name: name,
      notes: notes,
      frequencies: frequencies,
      description: description,
      isCustom: isCustom,
    );
  }

  @override
  TuningModel copyWith({
    String? id,
    String? name,
    List<String>? notes,
    List<double>? frequencies,
    String? description,
    bool? isCustom,
  }) {
    return TuningModel(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      frequencies: frequencies ?? this.frequencies,
      description: description ?? this.description,
      isCustom: isCustom ?? this.isCustom,
    );
  }
}
