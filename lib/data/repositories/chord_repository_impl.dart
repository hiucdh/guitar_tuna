import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/chord.dart';
import '../../domain/repositories/chord_repository.dart';
import '../models/chord_model.dart';

class ChordRepositoryImpl implements ChordRepository {
  // Static list of common guitar chords
  static const List<ChordModel> _chords = [
    // --- A ROOTS ---
    ChordModel(id: 'a_major', name: 'A Major', symbol: 'A', fingering: 'x02220'),
    ChordModel(id: 'a_minor', name: 'A Minor', symbol: 'Am', fingering: 'x02210'),
    ChordModel(id: 'a_7', name: 'A Dominant 7', symbol: 'A7', fingering: 'x02020'),
    ChordModel(id: 'a_maj7', name: 'A Major 7', symbol: 'Amaj7', fingering: 'x02120'),
    ChordModel(id: 'a_m7', name: 'A Minor 7', symbol: 'Am7', fingering: 'x02010'),

    // --- B ROOTS ---
    ChordModel(id: 'b_major', name: 'B Major', symbol: 'B', fingering: 'x24442', startFret: 1), // Barre at 2nd fret (depicted as 24442 relative to nut is tricky generally, but x24442 works if treating as absolute frets)
    // Actually for B Major (x24442), if startFret=1, then the "2" is the 2nd fret. 
    // let's stick to absolute fret numbers in string, and startFret logic in widget handles display.
    ChordModel(id: 'b_minor', name: 'B Minor', symbol: 'Bm', fingering: 'x24432', startFret: 1),
    ChordModel(id: 'b_7', name: 'B Dominant 7', symbol: 'B7', fingering: 'x21202'),
    ChordModel(id: 'b_maj7', name: 'B Major 7', symbol: 'Bmaj7', fingering: 'x24342'),
    ChordModel(id: 'b_m7', name: 'B Minor 7', symbol: 'Bm7', fingering: 'x20202'),

    // --- C ROOTS ---
    ChordModel(id: 'c_major', name: 'C Major', symbol: 'C', fingering: 'x32010'),
    ChordModel(id: 'c_minor', name: 'C Minor', symbol: 'Cm', fingering: 'x35543', startFret: 3), // Barre at 3rd
    ChordModel(id: 'c_7', name: 'C Dominant 7', symbol: 'C7', fingering: 'x32310'),
    ChordModel(id: 'c_maj7', name: 'C Major 7', symbol: 'Cmaj7', fingering: 'x32000'),
    ChordModel(id: 'c_m7', name: 'C Minor 7', symbol: 'Cm7', fingering: 'x3131x', startFret: 3), // Barre 3rd but simplistic shape: x 3 5 3 4 3

    // --- D ROOTS ---
    ChordModel(id: 'd_major', name: 'D Major', symbol: 'D', fingering: 'xx0232'),
    ChordModel(id: 'd_minor', name: 'D Minor', symbol: 'Dm', fingering: 'xx0231'),
    ChordModel(id: 'd_7', name: 'D Dominant 7', symbol: 'D7', fingering: 'xx0212'),
    ChordModel(id: 'd_maj7', name: 'D Major 7', symbol: 'Dmaj7', fingering: 'xx0222'),
    ChordModel(id: 'd_m7', name: 'D Minor 7', symbol: 'Dm7', fingering: 'xx0211'),

    // --- E ROOTS ---
    ChordModel(id: 'e_major', name: 'E Major', symbol: 'E', fingering: '022100'),
    ChordModel(id: 'e_minor', name: 'E Minor', symbol: 'Em', fingering: '022000'),
    ChordModel(id: 'e_7', name: 'E Dominant 7', symbol: 'E7', fingering: '020100'),
    ChordModel(id: 'e_maj7', name: 'E Major 7', symbol: 'Emaj7', fingering: '021100'),
    ChordModel(id: 'e_m7', name: 'E Minor 7', symbol: 'Em7', fingering: '020000'),

    // --- F ROOTS ---
    ChordModel(id: 'f_major', name: 'F Major', symbol: 'F', fingering: '133211', startFret: 1),
    ChordModel(id: 'f_minor', name: 'F Minor', symbol: 'Fm', fingering: '133111', startFret: 1),
    ChordModel(id: 'f_7', name: 'F Dominant 7', symbol: 'F7', fingering: '131211', startFret: 1),
    ChordModel(id: 'f_maj7', name: 'F Major 7', symbol: 'Fmaj7', fingering: 'x33210'), // Easier open shape or 132211
    ChordModel(id: 'f_m7', name: 'F Minor 7', symbol: 'Fm7', fingering: '131111', startFret: 1),

    // --- G ROOTS ---
    ChordModel(id: 'g_major', name: 'G Major', symbol: 'G', fingering: '320003'),
    ChordModel(id: 'g_minor', name: 'G Minor', symbol: 'Gm', fingering: '355333', startFret: 3),
    ChordModel(id: 'g_7', name: 'G Dominant 7', symbol: 'G7', fingering: '320001'),
    ChordModel(id: 'g_maj7', name: 'G Major 7', symbol: 'Gmaj7', fingering: '320002'),
    ChordModel(id: 'g_m7', name: 'G Minor 7', symbol: 'Gm7', fingering: '353333', startFret: 3),
  ];

  @override
  Future<Either<Failure, List<Chord>>> getChords() async {
    // Simulate async operation
    return Right(_chords);
  }

  @override
  Future<Either<Failure, Chord>> getChordById(String id) async {
    try {
      final chord = _chords.firstWhere((c) => c.id == id);
      return Right(chord);
    } catch (e) {
      return Left(UnexpectedFailure('Chord not found'));
    }
  }
}
