import 'dart:io';
import 'dart:typed_data';
import 'dart:math';

void main() {
  final file = File('assets/sounds/tick.wav');
  final int sampleRate = 44100;
  final int durationMs = 50; // Short click
  final int numSamples = (sampleRate * durationMs / 1000).round();
  final int numChannels = 1;
  final int byteRate = sampleRate * numChannels * 2; // 16-bit
  final int blockAlign = numChannels * 2;
  final int dataSize = numSamples * blockAlign;
  final int fileSize = 36 + dataSize;

  final bytes = BytesBuilder();

  // RIFF header
  bytes.add('RIFF'.codeUnits);
  bytes.add(_int32(fileSize));
  bytes.add('WAVE'.codeUnits);

  // fmt chunk
  bytes.add('fmt '.codeUnits);
  bytes.add(_int32(16)); // Subchunk1Size
  bytes.add(_int16(1)); // AudioFormat
  bytes.add(_int16(numChannels));
  bytes.add(_int32(sampleRate));
  bytes.add(_int32(byteRate));
  bytes.add(_int16(blockAlign));
  bytes.add(_int16(16)); // BitsPerSample

  // data chunk
  bytes.add('data'.codeUnits);
  bytes.add(_int32(dataSize));

  // Woodblock Synthesis
  // Fundamental + First Overtone for hollow sound
  double f1 = 800.0;
  double f2 = 1450.0; // Non-integer harmonic for wood sound

  for (int i = 0; i < numSamples; i++) {
    double t = i / sampleRate;
    
    // Envelope: Fast attack, fast decay
    double envelope = exp(-80.0 * t); 
    
    // Mixing frequencies
    double signal = 0.7 * sin(2 * pi * f1 * t) + 0.3 * sin(2 * pi * f2 * t);
    
    // Clip to valid range
    double val = signal * envelope * 28000.0; // Volume
    
    int sample = val.round().clamp(-32768, 32767);
    bytes.add(_int16(sample));
  }

  file.writeAsBytesSync(bytes.toBytes());
  print('Generated Woodblock Sound: assets/sounds/tick.wav');
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
