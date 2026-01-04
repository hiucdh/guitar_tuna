/// Interface for Metronome service
abstract class MetronomeService {
  /// Play a single tick sound
  Future<void> playTick();
  
  /// Prepare resources
  Future<void> init();
  
  /// Dispose resources
  Future<void> dispose();
}
