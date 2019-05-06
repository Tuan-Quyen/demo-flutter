import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/CustomScoreAnswered.dart';
import 'widgets/CustomAppBar.dart';
import 'package:flutter_app/models/responses/ResponseQuestion.dart';
import 'widgets/CustomLoadingProgress.dart';
import 'widgets/CustomQuestionView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<SecondPage> {
  bool hasLeft = true, hasRight = false, isLoading = false, isFirstLoad = true;
  int _page = 1;
  List<ResponseQuestion> _questionList = new List();
  var _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getQuestionData(_page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
          getQuestionData(_page);
        });
      }
    });
  }

  getQuestionData(int page) async {
    setState(() {
      isLoading = true;
    });
    String link =
        "https://api.stackexchange.com/2.2/questions?page=$page&pagesize=15&order=desc&sort=creation&site=stackoverflow&key=mq*Z3A9J)zXCIsTkyU9TQA((";
    final res = await http.get(link);
    if (res.statusCode == 200) {
      var rest = json.decode(res.body)["items"] as List;
      setState(() {
        isLoading = false;
        isFirstLoad = false;
        _questionList.addAll(rest
            .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
            .toList());
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Drawer _drawer() {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        new ListTile(
          title: new Text('First Menu Item'),
          onTap: () {
            Navigator.of(context).pop();
          },
        )
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
                tags: _questionList[position].topicTag,
                lastActivity: _questionList[position].lastActivityDate,
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
        body: Container(
            child: isFirstLoad
                ? LoadingProgress(isLoading: isFirstLoad)
                : ListView.separated(
                    controller: _scrollController,
                    separatorBuilder: (context, int index) => Divider(
                          height: 1,
                          color: Colors.black26,
                        ),
                    shrinkWrap: true,
                    itemCount: _questionList.length + 1,
                    itemBuilder: (context, position) {
                      if (position == _questionList.length && position != 0) {
                        return LoadingProgress(isLoading: isLoading);
                      } else if (position < _questionList.length) {
                        return _gestureDetector(position);
                      }
                    },
                  )));
  }
}
