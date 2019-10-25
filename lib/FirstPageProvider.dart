import 'package:flutter/material.dart';
import 'package:flutter_app/CounterBloc.dart';
import 'package:flutter_app/NavigateWidget.dart';
import 'package:provider/provider.dart';

class FirstPageProvider extends StatefulWidget {
  const FirstPageProvider();

  FirstPageProviderState createState() => FirstPageProviderState();
}

class FirstPageProviderState extends State<FirstPageProvider> {
  static CounterBloc counterBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final counterBlocs = Provider.of<CounterBloc>(context);

    if (counterBloc != counterBlocs) {
      counterBloc = counterBlocs;
      Future.microtask(() => counterBloc.raiseValue());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FirstPageProvider",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.teal,
        leading: NavigateWidget(context).backIconWidgetSetup(),
        actions: <Widget>[
          NavigateWidget(context).navigateIconWidgetSetup("secondPage")
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              counterBloc.valueCounter.toString(),
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
            )
          ],
        ),
      ),
    );
  }
}
