import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences? sharedPreferences;

  SharedPrefs();

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool? getBool(String key) {
    if (sharedPreferences != null) {
      return sharedPreferences!.getBool(key);
    } else {
      init();
    }
  }

  String? getString(String key) {
    if (sharedPreferences != null) {
      return sharedPreferences!.getString(key);
    } else {
      init();
    }
  }

  double? getDouble(String key) {
    if (sharedPreferences != null) {
      return sharedPreferences!.getDouble(key);
    } else {
      init();
    }
  }

  int? getInt(String key) {
    if (sharedPreferences != null) {
      return sharedPreferences!.getInt(key);
    } else {
      init();
    }
  }

  Future<bool> setBool(String key, bool value) async {
    if (sharedPreferences != null) {
      var result = await sharedPreferences!.setBool(key, value);
      await sharedPreferences!.reload();

      return result;
    } else {
      sharedPreferences = await SharedPreferences.getInstance();

      return await setBool(key, value);
    }
  }

  Future<bool> setString(String key, String value) async {
    if (sharedPreferences != null) {
      var result = await sharedPreferences!.setString(key, value);
      await sharedPreferences!.reload();

      return result;
    } else {
      sharedPreferences = await SharedPreferences.getInstance();

      return await setString(key, value);
    }
  }

  Future<bool> setDouble(String key, double value) async {
    if (sharedPreferences != null) {
      var result = await sharedPreferences!.setDouble(key, value);
      await sharedPreferences!.reload();

      return result;
    } else {
      sharedPreferences = await SharedPreferences.getInstance();

      return await setDouble(key, value);
    }
  }

  Future<bool> setInt(String key, int value) async {
    if (sharedPreferences != null) {
      var result = await sharedPreferences!.setInt(key, value);
      await sharedPreferences!.reload();

      return result;
    } else {
      sharedPreferences = await SharedPreferences.getInstance();

      return await setInt(key, value);
    }
  }
}
