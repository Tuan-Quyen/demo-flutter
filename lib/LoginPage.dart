import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widgets/CustomTextFieldLogin.dart';
import 'ultils/ValidateInput.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage>
    with TickerProviderStateMixin<LoginPage> {
  final _tfEmailController = TextEditingController();
  final _tfPassController = TextEditingController();
  AnimationController _controller;
  String _errorTextEmail, _errorTextPass;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: 150, lowerBound: 0, upperBound: 150.0, vsync: this);
    Future.delayed(Duration(seconds: 1)).then((v) {
      _controller.animateTo(0,
          curve: Curves.bounceInOut, duration: Duration(seconds: 1));
    });
  }

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
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          _controller.animateTo(150,
              curve: Curves.bounceIn, duration: Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    child: Image.asset('lib/images/flutter-icon.png',
                        fit: BoxFit.fill),
                  ),
                  builder: (BuildContext context, Widget child) {
                    return Container(
                      width: _controller.value,
                      height: _controller.value,
                      child: child,
                    );
                  },
                ),
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
                          Navigator.pushNamed(
                              context, '/QuestionPage');
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
