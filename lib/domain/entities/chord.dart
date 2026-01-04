import 'package:equatable/equatable.dart';

class Chord extends Equatable {
  final String id;
  final String name;
  final String symbol;
  /// Fingering pattern string.
  /// Length should be 6 characters (for 6 strings).
  /// 'x': Muted
  /// '0': Open
  /// '1'-'9': Fret number
  /// Example A Major: 'x02220'
  final String fingering;
  final int startFret;

  const Chord({
    required this.id,
    required this.name,
    required this.symbol,
    required this.fingering,
    this.startFret = 1,
  });

  @override
  List<Object?> get props => [id, name, symbol, fingering, startFret];
}
