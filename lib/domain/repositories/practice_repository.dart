import '../entities/backing_track.dart';

abstract class PracticeRepository {
  Future<List<BackingTrack>> getBackingTracks();
}
