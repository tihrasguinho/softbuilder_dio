import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late final SharedPreferences _prefs;

  LocalStorage() {
    _getPreferences();
  }

  _getPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // set value on shared preferences
  void set(String key, dynamic value) {
    if (value is String) {
      _prefs.setString(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is List<String>) {
      _prefs.setStringList(key, value);
    }
  }

  // get value on shared preferencecs
  dynamic get(String key) {
    if (_prefs.containsKey(key)) {
      return _prefs.get(key);
    } else {
      return null;
    }
  }

  // check if its exists on shared preferencs
  bool contains(String key) {
    return _prefs.containsKey(key);
  }

  // remove from shared preferences
  void remove(String key) {
    _prefs.remove(key);
  }
}
