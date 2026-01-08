import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _sharedPreferences;

SharedPreferences get sharedPreferences {
  assert(_sharedPreferences != null,
      'sharedPreferences uninitialized, call the init method');
  return _sharedPreferences!;
}

set sharedPreferences(SharedPreferences prefs) => _sharedPreferences ??= prefs;
