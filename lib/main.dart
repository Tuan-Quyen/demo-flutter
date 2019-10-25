import 'package:flutter/material.dart';
import 'package:flutter_app/CounterBloc.dart';
import 'package:flutter_app/FirstPageProvider.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/SecondPageProvider.dart';
import 'package:flutter_app/ThirdPageProvider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterBloc>.value(value: CounterBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          "firstPage": (context) => FirstPageProvider(),
          "secondPage": (context) => SecondPageProvider(),
          "thirdPage": (context) => ThirdPageProvider()
        },
      ),
    );
  }
}
