import 'package:flutter/material.dart';
import 'widgets/CustomAppBar.dart';
import 'package:flutter_app/models/responses/ResponseQuestion.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(SecondPage());

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<SecondPage> {
  bool hasLeft = true;
  bool hasRight = false;
  List<ResponseQuestion> _questionList = [];

  Future<List<ResponseQuestion>> getQuestionData() async {
    String link =
        "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=hot&site=stackoverflow&key=mq*Z3A9J)zXCIsTkyU9TQA((";
    var res = await http.get(Uri.encodeFull(link));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["items"] as List;
      print(rest);
      return rest
          .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
          .toList();
    }
  }

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
        hasRight: false,
      ),
      drawer: _drawer(),
      body: Center(
          child: new FutureBuilder(
              future: getQuestionData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _questionList.addAll(snapshot.data);
                  return ListView.builder(
                    itemCount: _questionList.length,
                    itemBuilder: (context, position) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _questionList[position].topicName,
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                      );
                    },
                  );
                }else{
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
