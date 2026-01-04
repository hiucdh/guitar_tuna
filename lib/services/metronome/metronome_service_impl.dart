import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'metronome_service.dart';

class MetronomeServiceImpl implements MetronomeService {
  final AudioPlayer _player = AudioPlayer();
  
  @override
  Future<void> init() async {
    // Preload the sound for lower latency
    try {
      await _player.setSource(AssetSource('sounds/tick.wav'));
      // Determine player mode using new API if needed, 
      // but usually default is low latency for short sounds.
      await _player.setReleaseMode(ReleaseMode.stop); 
    } catch (e) {
      debugPrint('Error initializing metronome: $e');
    }
  }

  @override
  Future<void> playTick() async {
    try {
      await _player.stop(); // Stop previous overlap
      await _player.resume(); // Resume if paused or start
      // Or simply play again
      await _player.play(AssetSource('sounds/tick.wav'), mode: PlayerMode.lowLatency);
    } catch (e) {
      debugPrint('Error playing tick: $e');
    }
  }

  @override
  Future<void> dispose() async {
    await _player.dispose();
  }
}
