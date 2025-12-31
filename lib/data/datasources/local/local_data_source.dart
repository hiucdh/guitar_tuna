import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/errors/exceptions.dart';

/// Local data source using SharedPreferences
class LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSource(this.sharedPreferences);

  // ============================================================
  // SETTINGS
  // ============================================================

  /// Gets settings JSON from local storage
  Future<Map<String, dynamic>?> getSettings() async {
    try {
      final jsonString = sharedPreferences.getString('settings');
      if (jsonString == null) return null;
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw DataReadException('Failed to read settings: $e');
    }
  }

  /// Saves settings JSON to local storage
  Future<void> saveSettings(Map<String, dynamic> settingsJson) async {
    try {
      final jsonString = json.encode(settingsJson);
      await sharedPreferences.setString('settings', jsonString);
    } catch (e) {
      throw DataWriteException('Failed to save settings: $e');
    }
  }

  /// Clears settings from local storage
  Future<void> clearSettings() async {
    try {
      await sharedPreferences.remove('settings');
    } catch (e) {
      throw DataWriteException('Failed to clear settings: $e');
    }
  }

  // ============================================================
  // TUNINGS
  // ============================================================

  /// Gets all custom tunings
  Future<List<Map<String, dynamic>>> getCustomTunings() async {
    try {
      final jsonString = sharedPreferences.getString('custom_tunings');
      if (jsonString == null) return [];

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      throw DataReadException('Failed to read custom tunings: $e');
    }
  }

  /// Saves custom tunings
  Future<void> saveCustomTunings(
    List<Map<String, dynamic>> tuningsJson,
  ) async {
    try {
      final jsonString = json.encode(tuningsJson);
      await sharedPreferences.setString('custom_tunings', jsonString);
    } catch (e) {
      throw DataWriteException('Failed to save custom tunings: $e');
    }
  }

  // ============================================================
  // GENERIC KEY-VALUE STORAGE
  // ============================================================

  /// Gets a string value
  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  /// Sets a string value
  Future<void> setString(String key, String value) async {
    try {
      await sharedPreferences.setString(key, value);
    } catch (e) {
      throw DataWriteException('Failed to set string: $e');
    }
  }

  /// Gets an int value
  int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }

  /// Sets an int value
  Future<void> setInt(String key, int value) async {
    try {
      await sharedPreferences.setInt(key, value);
    } catch (e) {
      throw DataWriteException('Failed to set int: $e');
    }
  }

  /// Gets a double value
  double? getDouble(String key) {
    return sharedPreferences.getDouble(key);
  }

  /// Sets a double value
  Future<void> setDouble(String key, double value) async {
    try {
      await sharedPreferences.setDouble(key, value);
    } catch (e) {
      throw DataWriteException('Failed to set double: $e');
    }
  }

  /// Gets a bool value
  bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  /// Sets a bool value
  Future<void> setBool(String key, bool value) async {
    try {
      await sharedPreferences.setBool(key, value);
    } catch (e) {
      throw DataWriteException('Failed to set bool: $e');
    }
  }

  /// Removes a value
  Future<void> remove(String key) async {
    try {
      await sharedPreferences.remove(key);
    } catch (e) {
      throw DataWriteException('Failed to remove key: $e');
    }
  }

  /// Clears all data
  Future<void> clear() async {
    try {
      await sharedPreferences.clear();
    } catch (e) {
      throw DataWriteException('Failed to clear data: $e');
    }
  }

  /// Checks if a key exists
  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }
}
