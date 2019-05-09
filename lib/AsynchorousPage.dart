import 'package:flutter/material.dart';
import 'package:flutter_app/network/Url.dart';
import 'widgets/CustomAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_app/models/responses/ResponseQuestion.dart';

class AsynchorousPage extends StatefulWidget {
  AsynchorousPage({Key key}) : super(key: key);

  @override
  _MyAsynchorousPageState createState() => _MyAsynchorousPageState();
}

class _MyAsynchorousPageState extends State<AsynchorousPage> {
  List<ResponseQuestion> _listHot = [], _listVotes = [];
  Future<List<ResponseQuestion>> _futureHot, _futureVotes;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _futureVotes = getQuestionVotes();
    _futureHot = getQuestionHot();
  }

  Future<List<ResponseQuestion>> getQuestionHot() async {
    final res = await http.get(BaseUrl.questionRequest(_page, "hot"));
    if (res.statusCode == 200) {
      var rest = json.decode(res.body)["items"] as List;
      print("Hot: " + DateTime.now().millisecond.toString());
      _listHot.addAll(rest
          .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
          .toList());
    }
  }

  Future<List<ResponseQuestion>> getQuestionVotes() async {
    final res = await http.get(BaseUrl.questionRequest(_page, "votes"));
    if (res.statusCode == 200) {
      var rest = json.decode(res.body)["items"] as List;
      print("Votes: " + DateTime.now().millisecond.toString());
      _listVotes.addAll(rest
          .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
          .toList());
    }
  }

  ListView _listView(List<ResponseQuestion> _list) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
        shrinkWrap: true,
        separatorBuilder: (context, int index) => IntrinsicHeight(
              child: Container(
                  margin: const EdgeInsets.only(left: 5,right: 5), color: Colors.white),
            ),
        itemBuilder: (context, position) {
          return Container(
              width: 100,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TransitionToImage(
                    image: AdvancedNetworkImage(_list[position].owner.iconUrl,
                        timeoutDuration: Duration(milliseconds: 2000),
                        useDiskCache: true,
                        cacheRule: CacheRule(
                            maxAge: const Duration(milliseconds: 3000))),
                    width: 100,
                    height: 120,
                    placeholder: Icon(Icons.error),
                    loadingWidget: Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      _list[position].owner.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: Text(
          "Asynchorous Page",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        hasRight: false,
        hasLeft: false,
        color: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              child: FutureBuilder(
                  future: _futureVotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                        );
                      default:
                        if (snapshot.hasError)
                          return new Text("Error: ${snapshot.error}");
                        else {
                          return _listView(_listVotes);
                        }
                    }
                  }),
            ),
            Container(
              height: 200,
              child: FutureBuilder(
                  future: _futureHot,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                        );
                      default:
                        if (snapshot.hasError)
                          return new Text("Error: ${snapshot.error}");
                        else {
                          return _listView(_listHot);
                        }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
