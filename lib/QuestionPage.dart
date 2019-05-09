import 'package:flutter/material.dart';
import 'package:flutter_app/network/Url.dart';
import 'package:flutter_app/widgets/CustomScoreAnswered.dart';
import 'widgets/CustomAppBar.dart';
import 'package:flutter_app/models/responses/ResponseQuestion.dart';
import 'widgets/CustomLoadingProgress.dart';
import 'widgets/CustomQuestionView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key}) : super(key: key);

  @override
  _MyQuestionPageState createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<QuestionPage> {
  bool hasLeft = false, hasRight = false, isLoading = false, isFirstLoad = true;
  int _page = 1;
  List<ResponseQuestion> _questionList = new List();
  var _scrollController = new ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getQuestionData(false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if(this.mounted) {
          setState(() {
            _page++;
            getQuestionData(false);
          });
        }
      }
    });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await getQuestionData(true);
    return null;
  }

  getQuestionData(bool isRefresh) async {
    if(this.mounted) {
      setState(() {
        isLoading = true;
      });
    }
    if (isRefresh) _page = 1;
    final res = await http.get(BaseUrl.questionRequest(_page,"hot"));
    if (res.statusCode == 200) {
      var rest = json.decode(res.body)["items"] as List;
      if(this.mounted) {
        setState(() {
          if (isRefresh) _questionList.clear();
          isLoading = false;
          isFirstLoad = false;
          _questionList.addAll(rest
              .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
              .toList());
        });
      }
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
          hasLeft: hasLeft,
          context: context,
          navigatorRoute: "/AsynchorousPage",
          hasRight: true,
          color: Colors.red[700],
        ),
        drawer: hasLeft ? _drawer() : null,
        body: Container(
            child: isFirstLoad
                ? LoadingProgress(isLoading: isFirstLoad)
                : RefreshIndicator(
                    child: ListView.separated(
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
                    ),
                    onRefresh: refreshList)));
  }
}
