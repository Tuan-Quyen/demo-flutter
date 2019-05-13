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
  var _future;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _future = future();
  }

  Future<Null> future() async {
    var future1 =
        await http.get(BaseUrl.questionRequest(_page, "hot")).then((res) {
      if (res.statusCode == 200) {
        var rest = json.decode(res.body)["items"] as List;
        print("Hot: " + DateTime.now().toString());
        _listHot.addAll(rest
            .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
            .toList());
        _listHot.elementAt(0).owner.setName = "adsasd";
      }
    });
    var future2 =
        await http.get(BaseUrl.questionRequest(_page, "votes")).then((res) {
      if (res.statusCode == 200) {
        var rest = json.decode(res.body)["items"] as List;
        print("Votes: " + DateTime.now().toString());
        _listVotes.addAll(rest
            .map<ResponseQuestion>((json) => ResponseQuestion.fromJson(json))
            .toList());
      }
    });
    _future = await future2;
    _future = await future1;
  }
  
  FutureBuilder _futureBuilder(List list){
    return FutureBuilder(
        future: _future,
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
                return _listView(list);
              }
          }
        });
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
          "Asynchorous Page",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        hasRight: true,
        hasLeft: false,
        context: context,
        navigatorRoute: "/NoAsynchorousPage",
        color: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              child: _futureBuilder(_listVotes)
            ),
            Container(
              height: 200,
              child: _futureBuilder(_listHot)
            )
          ],
        ),
      ),
    );
  }
}
