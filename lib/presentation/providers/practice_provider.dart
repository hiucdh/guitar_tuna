import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/backing_track.dart';
import '../../domain/repositories/practice_repository.dart';

class PracticeProvider extends ChangeNotifier {
  final PracticeRepository _repository;
  final AudioPlayer _player = AudioPlayer();

  PracticeProvider({required PracticeRepository repository}) : _repository = repository;

  List<BackingTrack> _tracks = [];
  bool _isLoading = false;
  BackingTrack? _currentTrack;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  List<BackingTrack> get tracks => _tracks;
  bool get isLoading => _isLoading;
  BackingTrack? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tracks = await _repository.getBackingTracks();
      
      // Listen to player state
      _player.onPlayerStateChanged.listen((state) {
        _isPlaying = state == PlayerState.playing;
        notifyListeners();
      });

      _player.onDurationChanged.listen((d) {
        _duration = d;
        notifyListeners();
      });

      _player.onPositionChanged.listen((p) {
        _position = p;
        notifyListeners();
      });
      
      _player.onPlayerComplete.listen((event) {
        _isPlaying = false;
        _position = Duration.zero;
        notifyListeners();
      });

    } catch (e) {
      debugPrint('Error loading practice tracks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> playTrack(BackingTrack track) async {
    try {
      if (_currentTrack?.id == track.id && _isPlaying) {
        await pause();
        return;
      }

      if (_currentTrack?.id != track.id) {
        await _player.stop();
        _currentTrack = track;
      }
      
      await _player.play(AssetSource(track.assetPath.replaceFirst('assets/', '')));
    } catch (e) {
      debugPrint('Error playing track: $e');
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }
  
  Future<void> stop() async {
    await _player.stop();
    _currentTrack = null;
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
