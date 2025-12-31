import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import '../../core/utils/logger.dart';

class AudioService {
  final _audioCapture = FlutterAudioCapture();
  // final _pitchDetector = PitchDetector();
  final _pitchController = StreamController<double>.broadcast();
  
  // Configuration
  static const int _sampleRate = 44100;
  static const int _bufferSize = 3000;

  bool _isRecording = false;

  Stream<double> get pitchStream => _pitchController.stream;

  Future<void> start() async {
    if (_isRecording) return;

    try {
      await _audioCapture.start(
        _listener, 
        _onError, 
        sampleRate: _sampleRate, 
        bufferSize: _bufferSize // Low buffer for lower latency
      );
      _isRecording = true;
      Logger.info('Audio service started');
    } catch (e) {
      Logger.error('Failed to start audio service', error: e);
      throw Exception('Failed to start audio capture: $e');
    }
  }

  Future<void> stop() async {
    if (!_isRecording) return;

    try {
      await _audioCapture.stop();
      _isRecording = false;
      Logger.info('Audio service stopped');
    } catch (e) {
       Logger.error('Failed to stop audio service', error: e);
    }
  }

  void _listener(dynamic obj) {
    // flutter_audio_capture returns either Float32List or Int16List depending on config
    // Default is usually Float32List. We need to convert if necessary.
    
    var buffer = <double>[];
    
    if (obj is Float32List) {
      buffer = obj.toList();
    } else if (obj is List<double>) {
      buffer = obj;
    } else if (obj is List<int>) {
       buffer = obj.map((e) => e.toDouble()).toList();
    } else {
      // Unknown format?
      return;
    }

    if (buffer.isEmpty) return;

    // Detect pitch
    // TODO: Fix PitchDetector method signature
    // final result = _pitchDetector.getPitch(buffer);
    
    // if (result.pitched) {
    //   // Add valid pitch to stream
    //   _pitchController.add(result.pitch);
    // }
  }

  void _onError(Object e) {
    Logger.error('Audio capture error', error: e);
    _pitchController.addError(e);
  }

  void dispose() {
    stop();
    _pitchController.close();
  }
}
