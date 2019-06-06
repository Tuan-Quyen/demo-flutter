import 'package:flutter/material.dart';

import 'BlocSharePreference.dart';
import 'OwnModel.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  BlocSharePreference bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocSharePreference();
    //bloc.getCounterInt();
    //bloc.getCounterDouble();
    //bloc.getCounterBool();
    //bloc.getCounterString();
    //bloc.getCounterListString();
    bloc.getOwner();
  }

  Text _text(String data) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notification"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, AsyncSnapshot<Object> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data is int) {
                final intCounter = snapshot.data as int;
                return _text(intCounter.toString());
              } else if (snapshot.data is double) {
                final doubleCounter = snapshot.data as double;
                return _text(doubleCounter.toString());
              } else if (snapshot.data is String) {
                final stringText = snapshot.data as String;
                return _text(stringText);
              } else if (snapshot.data is bool) {
                final check = snapshot.data as bool;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                      child: _text("Male"),
                      visible: check,
                    ),
                    Visibility(
                      child: _text("Female"),
                      visible: !check,
                    )
                  ],
                );
              } else if (snapshot.data is List<String>) {
                final list = snapshot.data as List<String>;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, position) {
                      return Container(
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        child: _text(list[position]),
                      );
                    });
              } else if (snapshot.data is Owner) {
                final data = snapshot.data as Owner;
                return data != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            data.iconUrl,
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.low,
                          ),
                          _text(data.name)
                        ],
                      )
                    : Container();
              }
            } else if (snapshot.hasError) {
              return _text(snapshot.error.toString());
            } else {
              return Container();
            }
          },
        ),

        //child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //bloc.saveCounterInt();
            //bloc.saveCounterDouble();
            //bloc.saveCounterBool();
            //bloc.saveCounterString();
            //bloc.saveCounterListString();
            bloc.saveOwner();
          }),
    );
  }
}
