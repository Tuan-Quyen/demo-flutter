import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/GeneresModels.dart';

class GeneresDialog {
  List<GeneresModels> _list = [];

  void addGeners() {
    _list.add(GeneresModels("popular", "Popular"));
    _list.add(GeneresModels("top_rated", "Top rated"));
    _list.add(GeneresModels("upcoming", "Up coming"));
    _list.add(GeneresModels("now_playing", "Now Playing"));
    _list.add(GeneresModels("latest", "Lastest"));
  }

  Widget buildPopupMenu(void choiceAction(GeneresModels choice)) {
    addGeners();
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
      child: PopupMenuButton<GeneresModels>(
        onSelected: choiceAction,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Generes",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(Icons.arrow_drop_down, size: 20),
              )
            ],
          ),
        ),
        itemBuilder: (BuildContext context) {
          return _list.map((GeneresModels choice) {
            return PopupMenuItem<GeneresModels>(
                child: Text(choice.generes), value: choice);
          }).toList();
        },
        offset: Offset(0, 100),
      ),
    );
  }
}
