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

  GestureDetector _gestureDetector(int position) {
    return new GestureDetector(
      child: Container(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ScoreAnsweredView(
                  score: _questionList[position].topicScore,
                  answered: _questionList[position].topicAnswer,
                  isAnswered: _questionList[position].hasAnswer),
              Expanded(
                  child: QuestionView(
                title: _questionList[position].topicName,
                questionId: _questionList[position].questionId.toString(),
                tags: _questionList[position].topicTag,
                context: context,
              )),
            ],
          ),
        ),
      ),
    );
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
                  return ListView.separated(
                    separatorBuilder: (context, int index) => Divider(
                          height: 1,
                          color: Colors.black26,
                        ),
                    shrinkWrap: true,
                    itemCount: _questionList.length,
                    itemBuilder: (context, position) {
                      return _gestureDetector(position);
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}

class QuestionView extends Container {
  QuestionView(
      {Key key,
      String title,
      List<String> tags,
      String questionId,
      BuildContext context})
      : super(
          key: key,
          constraints: const BoxConstraints(minHeight: 100),
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
                          fontSize: 20,
                          color: Color.fromARGB(255, 50, 110, 181)),
                    )),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Tags :",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}

class ScoreAnsweredView extends Container {
  static Image _voteImage(int answered, bool isAnswered) {
    if (answered != 0) {
      if (isAnswered) {
        return new Image.asset(
          'lib/images/ic_answers_accepted.png',
          width: 20,
          height: 20,
        );
      } else {
        return new Image.asset(
          'lib/images/ic_answers_non_zero.png',
          width: 20,
          height: 20,
        );
      }
    } else {
      return new Image.asset(
        'lib/images/ic_no_answers.png',
        width: 20,
        height: 20,
      );
    }
  }

  static Color _voteColorBg(bool isAnswered) {
    if (!isAnswered) {
      return Color.fromARGB(255, 233, 241, 247);
    } else {
      return Color.fromARGB(72, 109, 230, 153);
    }
  }

  static Color _voteColorNumber(bool isAnswered) {
    if (!isAnswered) {
      return Color.fromARGB(255, 127, 130, 125);
    } else {
      return Color.fromARGB(255, 16, 143, 79);
    }
  }

  ScoreAnsweredView({Key key, int score, int answered, bool isAnswered})
      : super(
          key: key,
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          width: 80,
          constraints: BoxConstraints(minHeight: 100),
          color: _voteColorBg(isAnswered),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    score.toString(),
                    style: TextStyle(
                        color: _voteColorNumber(isAnswered),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Image.asset(
                    'lib/images/ic_vote.png',
                    width: 20,
                    height: 20,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      answered.toString(),
                      style: TextStyle(
                          color: _voteColorNumber(isAnswered),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    _voteImage(answered, isAnswered)
                  ],
                ),
              )
            ],
          ),
        );
}
