import 'package:flutter/material.dart';

class TextFieldLogin extends Container {
  static OutlineInputBorder _outlineInputBorder(Color _color, double _width) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: _color, width: _width));
  }

  TextFieldLogin(
      {Key key,
        bool isObscure,
        TextEditingController controller,
        String errorText,
        String labelText})
      : super(
    key: key,
    color: Colors.white,
    child: TextField(
      controller: controller,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      decoration: new InputDecoration(
          isDense: true,
          labelText: labelText,
          errorText: errorText,
          enabledBorder: _outlineInputBorder(Colors.greenAccent, 2),
          focusedBorder: _outlineInputBorder(Colors.lightBlue, 2),
          errorBorder: _outlineInputBorder(Colors.red, 2),
          focusedErrorBorder: _outlineInputBorder(Colors.red, 2)),
      obscureText: isObscure,
      style: TextStyle(fontSize: 16),
    ),
  );
}