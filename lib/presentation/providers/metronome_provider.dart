import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../services/metronome/metronome_service.dart';

class MetronomeProvider extends ChangeNotifier {
  final MetronomeService _service;
  
  MetronomeProvider({required MetronomeService service}) : _service = service;

  // State
  int _bpm = 100; // Beats per minute
  bool _isPlaying = false;
  int _timeSignature = 4; // 4/4 usually
  int _currentBeat = 1;
  
  // Timer
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();

  // Getters
  int get bpm => _bpm;
  bool get isPlaying => _isPlaying;
  int get timeSignature => _timeSignature;
  int get currentBeat => _currentBeat;

  // Initialize
  Future<void> init() async {
    await _service.init();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _service.dispose();
    super.dispose();
  }

  // Actions
  void setBpm(int value) {
    if (value < 30 || value > 300) return;
    _bpm = value;
    if (_isPlaying) {
      _restartTimer();
    }
    notifyListeners();
  }

  void incrementBpm() => setBpm(_bpm + 1);
  void decrementBpm() => setBpm(_bpm - 1);

  void togglePlay() {
    if (_isPlaying) {
      stop();
    } else {
      start();
    }
  }

  void start() {
    if (_isPlaying) return;
    _isPlaying = true;
    _currentBeat = 1;
    notifyListeners();
    
    _stopwatch.reset();
    _stopwatch.start();
    
    _playClick(); // Play first immediately
    _scheduleNextTick();
  }

  void stop() {
    _isPlaying = false;
    _timer?.cancel();
    _stopwatch.stop();
    notifyListeners();
  }

  void _restartTimer() {
    _timer?.cancel();
    _scheduleNextTick();
  }

  void _scheduleNextTick() {
    if (!_isPlaying) return;
    
    // Calculate interval in milliseconds
    // 60000 ms / BPM = ms per beat
    final double beatIntervalMs = 60000 / _bpm;
    
    // Drift correction logic could be added here, 
    // but standard Timer.periodic is often not accurate enough for music.
    // For simplicity in this demo, we use a recusive Timer with basic correction could be:
    // Future.delayed might be better for adjusting.
    
    _timer = Timer(Duration(milliseconds: beatIntervalMs.round()), () {
      if (!_isPlaying) return;
       
      _incrementBeat();
      _playClick();
      _scheduleNextTick();
    });
  }

  void _incrementBeat() {
    _currentBeat++;
    if (_currentBeat > _timeSignature) {
      _currentBeat = 1;
    }
    notifyListeners();
  }

  void _playClick() {
    // In a real metronome, 1st beat might be accented (higher pitch).
    // For now, simple tick.
    _service.playTick();
  }
}
