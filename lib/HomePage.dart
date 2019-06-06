import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  final DatabaseReference databaseReference;

  const HomePage({Key key, @required this.databaseReference}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  var _titleController = new TextEditingController();
  var _descriptionController = new TextEditingController();
  String title = "", description = "";

  Text _text(String data) {
    return Text(
      data,
      style: TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  void sendData() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Map<String, String> map = {
      "title": _titleController.text.toString(),
      "description": _descriptionController.text.toString()
    };
    widget.databaseReference.child("first_data").set(map).then((_) {
      _titleController.clear();
      _descriptionController.clear();
    });
  }

  void updateData() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Map<String, String> map = {
      "title": _titleController.text.toString(),
      "description": _descriptionController.text.toString()
    };
    widget.databaseReference.child("first_data").update(map).then((_) {
      _titleController.clear();
      _descriptionController.clear();
    });
  }

  void getData() {
    widget.databaseReference
        .child("first_data")
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        title = snapshot.value['title'] != null ? snapshot.value['title'] : "";
        description = snapshot.value['description'] != null
            ? snapshot.value['description']
            : "";
      });
    });
  }

  void deleteData() {
    widget.databaseReference
        .child("first_data")
        .child("description")
        .remove()
        .then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notification"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _titleController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.black45)),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: "Description",
                        hintStyle: TextStyle(color: Colors.black45)),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                RaisedButton(
                    child: _text("Send Data"), onPressed: () => sendData()),
                RaisedButton(
                    child: _text("Get Data"), onPressed: () => getData()),
                RaisedButton(
                    child: _text("Update Data"), onPressed: () => updateData()),
                RaisedButton(
                    child: _text("Delete Data"), onPressed: () => deleteData()),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _text(title),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: _text(description),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
