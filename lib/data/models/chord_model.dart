import '../../domain/entities/chord.dart';

class ChordModel extends Chord {
  const ChordModel({
    required super.id,
    required super.name,
    required super.symbol,
    required super.fingering,
    super.startFret,
  });

  factory ChordModel.fromEntity(Chord chord) {
    return ChordModel(
      id: chord.id,
      name: chord.name,
      symbol: chord.symbol,
      fingering: chord.fingering,
      startFret: chord.startFret,
    );
  }
}
