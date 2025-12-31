import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  // The package handles platform-specific implementations automatically
  if (kIsWeb) {
    debugPrint('Running on web platform');
  }
  
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(GuitarTunaApp(sharedPreferences: sharedPreferences));
}
