import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuestionView extends Container {
  static Widget getTextWidgets(List<String> strings) {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < strings.length; i++) {
      if (i < strings.length - 1) {
        list.add(new Text(
          strings[i] + ",",
          style: _textStyle(),
        ));
      } else {
        list.add(new Text(
          strings[i],
          style: _textStyle(),
        ));
      }
    }
    return new Wrap(spacing: 4, children: list);
  }

  static TextStyle _textStyle() {
    return TextStyle(color: Color.fromARGB(255, 107, 130, 135), fontSize: 12);
  }

  static String _datetime(int lastActivity) {
    int lastActivityTime =
        DateTime.fromMillisecondsSinceEpoch(lastActivity * 1000)
            .millisecondsSinceEpoch;
    int now = DateTime.now().millisecondsSinceEpoch;
    double result = (now - lastActivityTime) / 1000;
    int resultTime =
        int.parse(new NumberFormat('####', "en_US").format(result));
    if (resultTime < 60) {
      return resultTime.toString() + " second agos";
    } else if (resultTime < 3600) {
      return (resultTime % 60).toString() + " minute agos";
    } else if (resultTime < 86400) {
      return (resultTime % 3600).toString() + " day agos";
    } else if (resultTime < 604800) {
      return (resultTime % 86400).toString() + " month agos";
    } else {
      return DateFormat('dd-MM-yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(lastActivity));
    }
  }

  QuestionView(
      {Key key,
      String title,
      List<String> tags,
      int lastActivity,
      BuildContext context})
      : super(
          key: key,
          constraints: const BoxConstraints(minHeight: 50),
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 50, 110, 181)),
                    )),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: getTextWidgets(tags),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        _datetime(lastActivity),
                        style: _textStyle(),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        );
}
