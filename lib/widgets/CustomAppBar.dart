import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
      {Key key,
      BuildContext context,
      Widget title,
      Color color,
      bool hasLeft,
      bool hasRight,
      String navigatorRoute})
      : super(
          key: key,
          title: title,
          leading: hasLeft
              ? Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.list, size: 30),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                })
              : null,
          actions: hasRight
              ? <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '$navigatorRoute');
                      },
                    ),
                  ),
                ]
              : null,
          centerTitle: true,
          backgroundColor: color,
        );
}
