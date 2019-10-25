import 'package:flutter/material.dart';
import 'package:flutter_app/CounterBloc.dart';
import 'package:flutter_app/NavigateWidget.dart';
import 'package:provider/provider.dart';

class SecondPageProvider extends StatefulWidget {
  const SecondPageProvider();

  _SecondPageProviderState createState() => _SecondPageProviderState();
}

class _SecondPageProviderState extends State<SecondPageProvider> {
  @override
  Widget build(BuildContext context) {
    final counterBloc = Provider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SecondPageProvider",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.teal,
        leading: NavigateWidget(context).backIconWidgetSetup(),
        actions: <Widget>[
          NavigateWidget(context).navigateIconWidgetSetup("thirdPage")
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              counterBloc.valueCounter.toString() +
                  counterBloc.valueMath +
                  counterBloc.valueChange.toString(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            RaisedButton(
              child: Text(
                "Increase value",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              color: Colors.blue,
              onPressed: () {
                counterBloc.increaseValue();
              },
            ),
            RaisedButton(
              child: Text(
                "Decrease value",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              color: Colors.blue,
              onPressed: () {
                counterBloc.decreaseValue();
              },
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.tealAccent,
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: counterBloc.valueChange.toString(),
                ),
                onSubmitted: (keyWord) {
                  counterBloc.inputValueChange(int.parse(keyWord));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
