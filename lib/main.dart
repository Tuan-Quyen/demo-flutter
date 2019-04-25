import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/SecondPage.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        routes: <String, WidgetBuilder>{
          '/SecondPage': (BuildContext context) => SecondPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    maxLines: 1,
                    decoration: new InputDecoration(
                        isDense: true,
                        labelText: "Email",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlue, width: 2))),
                    obscureText: false,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    maxLines: 1,
                    decoration: new InputDecoration(
                        isDense: true,
                        labelText: "Password",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlue, width: 2))),
                    obscureText: true,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
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
                      Navigator.pushReplacementNamed(context, '/SecondPage');
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
