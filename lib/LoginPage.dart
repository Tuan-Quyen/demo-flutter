import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/CustomTextFieldLogin.dart';
import 'ultils/ValidateInput.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {
  final _tfEmailController = TextEditingController();
  final _tfPassController = TextEditingController();
  String _errorTextEmail, _errorTextPass;

  @override
  void dispose() {
    _tfEmailController.dispose();
    _tfPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).detach();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 150),
                child: Image.asset('lib/images/flutter-icon.png',
                    width: 100, height: 100),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  "Flutter",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.lightBlue[300],
                        )
                      ]),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: TextFieldLogin(
                    isObscure: false,
                    controller: _tfEmailController,
                    errorText: _errorTextEmail,
                    labelText: "Email",
                  )),
              Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextFieldLogin(
                    isObscure: true,
                    controller: _tfPassController,
                    errorText: _errorTextPass,
                    labelText: "Password",
                  )),
              Container(
                margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                constraints: BoxConstraints.expand(height: 50),
                child: RaisedButton(
                    child: const Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    splashColor: Colors.blueGrey,
                    textColor: Colors.lightBlue,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (ValidateInput.checkFinalValidate(
                            _tfEmailController.text, _tfPassController.text)) {
                          Navigator.pushReplacementNamed(
                              context, '/ImageLoadPage');
                        } else {
                          _errorTextEmail = ValidateInput.validateEmail(
                              _tfEmailController.text);
                          _errorTextPass = ValidateInput.validatePassWord(
                              _tfPassController.text);
                        }
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
