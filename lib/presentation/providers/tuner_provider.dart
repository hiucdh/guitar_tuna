import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/usecases/detect_pitch.dart';
import '../../domain/entities/tuning.dart';
import '../../domain/usecases/calculate_cents.dart';
import '../../core/utils/logger.dart';

/// Provider for tuner state management
class TunerProvider extends ChangeNotifier {
  final DetectPitch detectPitch;
  final CalculateCents calculateCents;

  TunerProvider({
    required this.detectPitch,
    required this.calculateCents,
  });

  // Tuner state
  bool _isListening = false;
  StreamSubscription<double>? _pitchSubscription; // Subscription to pitch stream
  double? _detectedFrequency;
  String? _detectedNote;
  int? _detectedOctave;
  double _cents = 0.0;
  Tuning? _selectedTuning;
  int _selectedStringIndex = 0;

  // Getters
  bool get isListening => _isListening;
  double? get detectedFrequency => _detectedFrequency;
  String? get detectedNote => _detectedNote;
  int? get detectedOctave => _detectedOctave;
  double get cents => _cents;
  Tuning? get selectedTuning => _selectedTuning;
  int get selectedStringIndex => _selectedStringIndex;

  /// Checks if currently in tune
  bool get isInTune => calculateCents.isInTune(_cents);

  /// Gets tuning status (sharp, flat, or in-tune)
  String get tuningStatus {
    if (isInTune) return 'In Tune';
    if (_cents > 0) return 'Sharp';
    return 'Flat';
  }

  /// Starts listening for pitch
  Future<void> startListening() async {
    if (_isListening) return;

    _isListening = true;
    Logger.info('Started listening for pitch');
    notifyListeners();

    final result = await detectPitch.execute();

    result.fold(
      (failure) {
        Logger.error('Failed to start pitch detection: ${failure.message}');
        _isListening = false;
        notifyListeners();
      },
      (stream) {
        _pitchSubscription = stream.listen(
          (frequency) {
            updateFrequency(frequency);
          },
          onError: (error) {
            Logger.error('Pitch detection error: $error');
          },
        );
      },
    );
  }

  /// Stops listening for pitch
  Future<void> stopListening() async {
    if (!_isListening) return;
    
    await _pitchSubscription?.cancel();
    _pitchSubscription = null;
    
    await detectPitch.stop();

    _isListening = false;
    _detectedFrequency = null;
    _detectedNote = null;
    _detectedOctave = null;
    _cents = 0.0;
    Logger.info('Stopped listening for pitch');
    notifyListeners();
  }

  /// Updates detected frequency
  void updateFrequency(double frequency) {
    _detectedFrequency = frequency;

    // Calculate cents offset if tuning is selected
    if (_selectedTuning != null && _selectedStringIndex >= 0) {
      final targetFrequency =
          _selectedTuning!.frequencies[_selectedStringIndex];
      _cents = calculateCents.execute(frequency, targetFrequency);
    }

    notifyListeners();
  }

  /// Sets selected tuning
  void setTuning(Tuning tuning) {
    _selectedTuning = tuning;
    _selectedStringIndex = 0; // Reset to first string
    Logger.info('Selected tuning: ${tuning.name}');
    notifyListeners();
  }

  /// Sets selected string index
  void setStringIndex(int index) {
    if (_selectedTuning != null &&
        index >= 0 &&
        index < _selectedTuning!.stringCount) {
      _selectedStringIndex = index;
      Logger.info('Selected string: $index');
      notifyListeners();
    }
  }

  /// Gets target frequency for current string
  double? get targetFrequency {
    if (_selectedTuning == null) return null;
    return _selectedTuning!.frequencies[_selectedStringIndex];
  }

  /// Gets target note for current string
  String? get targetNote {
    if (_selectedTuning == null) return null;
    return _selectedTuning!.notes[_selectedStringIndex];
  }

  /// Resets tuner state
  void reset() {
    _detectedFrequency = null;
    _detectedNote = null;
    _detectedOctave = null;
    _cents = 0.0;
    notifyListeners();
  }
}
