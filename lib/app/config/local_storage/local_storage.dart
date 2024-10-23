import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _prefs;
  LocalStorage(this._prefs);

/////////////////////////////////////////////////

  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  String get user {
    return _prefs.getString('user') ?? '';
  }

  set user(String value) {
    _prefs.setString('user', value);
  }

  String get disco {
    return _prefs.getString('disco') ?? '';
  }

  set disco(String value) {
    _prefs.setString('disco', value);
  }

  int get id {
    return _prefs.getInt('id') ?? 0;
  }

  set id(int value) {
    _prefs.setInt('id', value);
  }


    String get fToken {
    return _prefs.getString('fToken') ?? '';
  }

  set fToken(String value) {
    _prefs.setString('fToken', value);
  }

 
  String get theme {
    return _prefs.getString('theme') ?? '';
  }

  set theme(String value) {
    _prefs.setString('theme', value);
  }
}
