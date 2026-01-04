import 'package:flutter/material.dart';
import '../../domain/entities/chord.dart';
import '../../domain/usecases/get_chords.dart';

class ChordProvider extends ChangeNotifier {
  final GetChords getChords;

  ChordProvider({required this.getChords});

  List<Chord> _chords = [];
  bool _isLoading = false;
  String? _error;

  List<Chord> get chords => _chords;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadChords() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await getChords.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (data) {
        _chords = data;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
