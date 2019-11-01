import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CounterBloc extends ChangeNotifier {
  List<String> _counterList = new List();
  int _valueChange = 0;
  String _math = "+";

  final BehaviorSubject<int> _valueCounter = BehaviorSubject();

  BehaviorSubject<int> get valueCounter => _valueCounter;

  int get valueChange => _valueChange;

  List<String> get counterList => _counterList;

  String get valueMath => _math;

  raiseValue() {
    Future.delayed(Duration(seconds: 2)).then((v) {
      valueCounter.sink.add(20);
      print(valueCounter);
      notifyListeners();
    });
  }

  increaseValue() {
    int temp = valueCounter.value;
    valueCounter.value = valueCounter.value + _valueChange;
    _math = "+";
    _counterList.add(temp.toString() +
        _math +
        _valueChange.toString() +
        "=" +
        valueCounter.value.toString());
    valueCounter.sink.add(valueCounter.value);
    print(_counterList.toString());
    notifyListeners();
  }

  decreaseValue() {
    int temp = valueCounter.value;
    valueCounter.value = valueCounter.value - _valueChange;
    _math = "-";
    _counterList.add(temp.toString() +
        _math +
        _valueChange.toString() +
        "=" +
        valueCounter.value.toString());
    print(_counterList.toString());
    valueCounter.sink.add(valueCounter.value);
    notifyListeners();
  }

  inputValueChange(int value) {
    _valueChange = value;
    notifyListeners();
  }

  removeItem(int position) {
    _counterList.removeAt(position);
    notifyListeners();
  }
}
