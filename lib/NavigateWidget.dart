import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigateWidget {
  final BuildContext context;

  NavigateWidget(this.context);

  Widget backIconWidgetSetup() {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 24,
        ),
        onPressed: () => Navigator.pop(context));
  }

  Widget navigateIconWidgetSetup(String nameNavigateScreen) {
    return IconButton(
        icon: Icon(
          Icons.arrow_forward,
          size: 24,
        ),
        onPressed: () {
          Navigator.pushNamed(context, nameNavigateScreen);
        });
  }
}
