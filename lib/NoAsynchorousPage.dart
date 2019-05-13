import 'package:flutter/material.dart';
import 'package:flutter_app/network/Url.dart';
import 'widgets/CustomAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/CustomLoadingProgress.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_app/models/responses/ResponseQuestion.dart';

class NoAsynchorousPage extends StatefulWidget {
  NoAsynchorousPage({Key key}) : super(key: key);

  @override
  _MyNoAsynchorousPageState createState() => _MyNoAsynchorousPageState();
}

class _MyNoAsynchorousPageState extends State<NoAsynchorousPage> {
  List<ResponseQuestion> _listHot = [], _listVotes = [];
  int _page = 1;
  bool isLoadHot = true, isLoadVotes = true;

  @override
  void initState() {
    super.initState();
    getQuestionHot();
    getQuestionVotes();
  }

  getQuestionHot() async {
    final res = await http.get(BaseUrl.questionRequest(_page, "hot"));
    if (res.statusCode == 200) {
      var rest = json.decode(res.body)["items"] as List;
      print("Hot: " + DateTime.now().millisecond.toString());
      if (this.mounted) {
        setState(() {
          isLoadHot = false;
          _listHot.addAll(rest
              .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
              .toList());
          _listHot.elementAt(0).owner.setName = "adsasd";
        });
      }
    }
  }

  getQuestionVotes() async {
    final res = await http.get(BaseUrl.questionRequest(_page, "votes"));
    if (res.statusCode == 200) {
      var rest = json.decode(res.body)["items"] as List;
      print("Votes: " + DateTime.now().millisecond.toString());
      if (this.mounted) {
        setState(() {
          isLoadVotes = false;
          _listVotes.addAll(rest
              .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
              .toList());
        });
      }
    }
  }

  ListView _listView(List<ResponseQuestion> _list) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
        shrinkWrap: true,
        separatorBuilder: (context, int index) => IntrinsicHeight(
              child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  color: Colors.white),
            ),
        itemBuilder: (context, position) {
          return Container(
              width: 100,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TransitionToImage(
                    image: AdvancedNetworkImage(_list[position].owner.getIcon,
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
                      _list[position].owner.getName,
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
          "No Asynchorous Page",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        hasRight: true,
        hasLeft: false,
        color: Colors.lightBlue,
        context: context,
        navigatorRoute: "/GalleryPage",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              child: isLoadVotes
                  ? LoadingProgress(
                isLoading: isLoadVotes,
              )
                  : _listView(_listVotes),
            ),
            Container(
                height: 200,
                child: isLoadHot
                    ? LoadingProgress(
                        isLoading: isLoadHot,
                      )
                    : _listView(_listHot))
          ],
        ),
      ),
    );
  }
}
