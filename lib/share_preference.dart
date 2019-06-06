import 'package:shared_preferences/shared_preferences.dart';

import 'Constant.dart';

class SharePreference {
  SharedPreferences _preferences;

  Future saveInt(int value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setInt(Constant.COUNTER_INT, value);
  }

  Future<int> getInt() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getInt(Constant.COUNTER_INT);
  }

  Future saveDouble(double value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setDouble(Constant.COUNTER_DOUBLE, value);
  }

  Future<double> getDouble() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getDouble(Constant.COUNTER_DOUBLE);
  }

  Future saveString(String value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString(Constant.STRING, value);
  }

  Future<String> getString() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getString(Constant.STRING);
  }

  Future saveBool(bool value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(Constant.BOOL, value);
  }

  Future<bool> getBool() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getBool(Constant.BOOL);
  }

  Future saveListString(List<String> value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setStringList(Constant.LIST_STRING, value);
  }

  Future<List<String>> getListString() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getStringList(Constant.LIST_STRING);
  }

  Future saveObject(String value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString(Constant.OBJECT, value);
  }

  Future<String> getObject() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getString(Constant.OBJECT);
  }
}
