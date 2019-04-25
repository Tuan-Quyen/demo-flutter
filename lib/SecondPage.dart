import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/CustomAppBar.dart';

void main() => runApp(SecondPage());

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<SecondPage> {
  bool hasLeft = true;
  bool hasRight = false;

  Drawer _drawer() {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        new DrawerHeader(
          child: new Text('Header'),
        ),
        new ListTile(
          title: new Text('First Menu Item'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        new ListTile(
          title: new Text('Second Menu Item'),
          onTap: () {},
        ),
        new Divider(),
        new ListTile(
          title: new Text('About'),
          onTap: () {},
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Flutter",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        hasLeft: true,
        hasRight: true,
      ),
      drawer: _drawer(),
      body: Center(
        child: RaisedButton(
            child: Text('Back To HomeScreen'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () { SystemChannels.platform.invokeMethod('SystemNavigator.pop');}),
      ),
    );
  }
}
