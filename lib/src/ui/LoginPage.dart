import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/LoginBloc.dart';
import 'package:flutter_app/src/blocs/events/AuthencationEvent.dart';
import 'package:flutter_app/src/blocs/states/AuthencationState.dart';
import 'package:flutter_app/src/responsitory/UserResponsitory.dart';
import 'package:flutter_app/src/ui/widgets/CustomTextFieldLogin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _tfEmailController = TextEditingController();
  final _tfPassController = TextEditingController();
  static UserResponsitory _userResponsitory = UserResponsitory();
  final UserBloc _userBloc = UserBloc(userResponsitory: _userResponsitory);
  @override
  void dispose() {
    _tfEmailController.dispose();
    _tfPassController.dispose();
    _userBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
          child: BlocBuilder(
              bloc: _userBloc,
              builder: (BuildContext context, state) {
                if (state is LoginLoading) {
                  return Container(child: CircularProgressIndicator());
                } else if (state is LoginInitial || state is LoginFailure) {
                  return Form(state);
                } else if (state is LoginSuccess) {
                  return HomePage();//Navigator.of(context).pushReplacementNamed("/MoviePage");
                  //return MoviePage();
                }
              })),
    );
  }

  Widget Form(var state) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).detach();
        },
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
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
                errorText: state is LoginFailure ? state.error : null,
                labelText: "Email",
              )),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: TextFieldLogin(
                isObscure: true,
                controller: _tfPassController,
                errorText: state is LoginFailure ? state.error : null,
                labelText: "Password",
              )),
          Container(
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              constraints: BoxConstraints.expand(height: 50),
              child: RaisedButton(
                  child: const Text(
                    "Sign in",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  splashColor: Colors.blueGrey,
                  textColor: Colors.lightBlue,
                  color: Colors.white,
                  onPressed: () {
                    _userBloc.dispatch(LoginEvent(
                        userName: _tfEmailController.text,
                        passWord: _tfPassController.text));
                  }))
        ])));
  }
}
