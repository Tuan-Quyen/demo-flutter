import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key key, Widget title, bool hasLeft, bool hasRight})
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
                      icon: Image.asset(
                        'images/butterfly-icon.png',
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ]
              : null,
          centerTitle: true,
          backgroundColor: Colors.red[700],
        );
}
