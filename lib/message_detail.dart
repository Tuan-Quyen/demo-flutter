
import 'package:flutter/material.dart';
import 'model/NotificationBase.dart';

class DetailPage extends StatefulWidget {

  NotificationData data;

  DetailPage(this.data);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(data);
  }
}

class _DetailPageState extends State<DetailPage> {
  NotificationData data;

  _DetailPageState(this.data);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      navigatorKey: navigatorKey,
      home: new Scaffold(
//        endDrawer: Drawer(),
        appBar: AppBar(
          title: Text(data.title),
          leading: IconButton(icon:Icon(Icons.chevron_left),onPressed:() => Navigator.pop(context, false),),
        ),
        body: new Container(),
      ),
    );
  }
}