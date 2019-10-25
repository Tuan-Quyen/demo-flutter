import 'package:flutter/material.dart';
import 'package:flutter_app/NavigateWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  AnimationController _controller;
  bool isSmall = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(upperBound: 300, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          NavigateWidget(context).navigateIconWidgetSetup("firstPage")
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              builder: (context, Widget child) {
                return Container(
                  width: 300,
                  height: 100,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: child,
                        left: _controller.value,
                      ),
                    ],
                  ),
                );
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text(
                "Tap animation",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _controller
                    .animateTo(200, duration: Duration(seconds: 1))
                    .then((v) {
                  _controller.animateBack(0,
                      duration: Duration(seconds: 1),
                      curve: Curves.linearToEaseOut);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
