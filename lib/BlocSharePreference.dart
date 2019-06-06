import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/share_preference.dart';

import 'OwnModel.dart';

class BlocSharePreference {
  int counterInt;
  double counterDouble;
  String counterString;
  bool counterBool;
  List<String> counterListString;
  Owner owner;

  StreamController _controller = new StreamController<Object>();

  Stream<Object> get stream => _controller.stream;

  saveCounterInt() {
    counterInt += 1;
    SharePreference().saveInt(counterInt);
    _controller.sink.add(counterInt);
  }

  getCounterInt() async {
    await SharePreference().getInt().then((value) =>
        value != null && value is int ? counterInt = value : counterInt = 0);
    _controller.sink.add(counterInt);
  }

  saveCounterDouble() {
    counterDouble += 1.3;
    SharePreference().saveDouble(counterDouble);
    _controller.sink.add(counterDouble);
  }

  getCounterDouble() async {
    await SharePreference().getDouble().then((value) =>
        value != null && value is double
            ? counterDouble = value
            : counterDouble = 0.0);
    _controller.sink.add(counterDouble);
  }

  saveCounterString() {
    counterString += "counter text";
    SharePreference().saveString(counterString);
    _controller.sink.add(counterString);
  }

  getCounterString() async {
    await SharePreference().getString().then((value) =>
        value != null && value is String
            ? counterString = value
            : counterString = "");
    _controller.sink.add(counterString);
  }

  saveCounterBool() {
    counterBool ? counterBool = false : counterBool = true;
    SharePreference().saveBool(counterBool);
    _controller.sink.add(counterBool);
  }

  getCounterBool() async {
    await SharePreference().getBool().then((value) =>
        value != null && value is bool
            ? counterBool = value
            : counterBool = false);
    _controller.sink.add(counterBool);
  }

  saveCounterListString() {
    counterListString.add("example flutter add an item list string");
    SharePreference().saveListString(counterListString);
    _controller.sink.add(counterListString);
  }

  getCounterListString() async {
    await SharePreference().getListString().then((value) =>
        value != null && value is List<String>
            ? counterListString = value
            : counterListString = []);
    _controller.sink.add(counterListString);
  }

  saveOwner() {
    owner = Owner(
        iconUrl:
            "https://blog.codemagic.io/uploads/CM_Android-dev-Flutter.9c02e273ebcd875d17b80037b2147c68cc0f5055dd3f1b9d663ebedec3d66ba7.png",
        name: "Quyen test flutter");
    String string = jsonEncode(owner.toJson());
    SharePreference().saveObject(string);
    _controller.sink.add(owner);
  }

  getOwner() async {
    await SharePreference().getObject().then((value) {
      if (value != null && value is String) {
        Map ownerMap = jsonDecode(value);
        owner = Owner.fromJson(ownerMap);
      } else {
        owner = null;
      }
    });
    _controller.sink.add(owner);
  }

  dispose() {
    _controller.close();
  }
}
