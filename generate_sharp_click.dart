import 'dart:io';
import 'dart:typed_data';
import 'dart:math';

void main() {
  final file = File('assets/sounds/tick.wav');
  final int sampleRate = 44100;
  final int durationMs = 30; // Very short and sharp
  final int numSamples = (sampleRate * durationMs / 1000).round();
  final int numChannels = 1;
  final byteRate = sampleRate * numChannels * 2;
  final blockAlign = numChannels * 2;
  final dataSize = numSamples * blockAlign;
  final fileSize = 36 + dataSize;

  final bytes = BytesBuilder();

  // Header
  bytes.add('RIFF'.codeUnits);
  bytes.add(_int32(fileSize));
  bytes.add('WAVE'.codeUnits);
  bytes.add('fmt '.codeUnits);
  bytes.add(_int32(16));
  bytes.add(_int16(1));
  bytes.add(_int16(numChannels));
  bytes.add(_int32(sampleRate));
  bytes.add(_int32(byteRate));
  bytes.add(_int16(blockAlign));
  bytes.add(_int16(16));
  bytes.add('data'.codeUnits);
  bytes.add(_int32(dataSize));

  // Sound Synthesis: Sharp Digital Click
  // High frequency (2200Hz) with fast exponential decay
  double frequency = 2200.0; 
  
  for (int i = 0; i < numSamples; i++) {
    double t = i / sampleRate;
    // Exponential decay to make it percussive
    double envelope = exp(-200.0 * t); 
    
    double signal = sin(2 * pi * frequency * t);
    
    // Add a tiny bit of noise for "mechanical" texture
    double noise = (Random().nextDouble() - 0.5) * 0.1;
    
    int sample = ((signal + noise) * envelope * 30000).round().clamp(-32768, 32767);
    bytes.add(_int16(sample));
  }

  file.writeAsBytesSync(bytes.toBytes());
  print('Generated Sharp Click: assets/sounds/tick.wav');
}

List<int> _int32(int value) {
  var b = ByteData(4);
  b.setInt32(0, value, Endian.little);
  return b.buffer.asUint8List();
}

List<int> _int16(int value) {
  var b = ByteData(2);
  b.setInt16(0, value, Endian.little);
  return b.buffer.asUint8List();
}
