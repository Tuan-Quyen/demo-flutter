import 'package:flutter/material.dart';

class CounterBloc extends ChangeNotifier {
  List<String> _counterList = new List();
  int _counter = 0, _valueChange = 0;
  String _math = "+";

  int get valueCounter => _counter;

  int get valueChange => _valueChange;

  List<String> get counterList => _counterList;

  String get valueMath => _math;

  raiseValue() {
    Future.delayed(Duration(seconds: 2)).then((v) {
      _counter = 20;
      print(valueCounter);
      notifyListeners();
    });
  }

  increaseValue() {
    int temp = _counter;
    _counter = valueCounter + _valueChange;
    _math = "+";
    _counterList.add(temp.toString() +
        _math + _valueChange.toString() +
        "=" +
        _counter.toString() );
    print(_counterList.toString());
    notifyListeners();
  }

  decreaseValue() {
    int temp = _counter;
    _counter = valueCounter - _valueChange;
    _math = "-";
    _counterList.add(temp.toString() +
        _math + _valueChange.toString() +
        "=" +
        _counter.toString() );
    print(_counterList.toString());
    notifyListeners();
  }

  inputValueChange(int value) {
    _valueChange = value;
    notifyListeners();
  }

  removeItem(int position){
    _counterList.removeAt(position);
    notifyListeners();
  }
}
