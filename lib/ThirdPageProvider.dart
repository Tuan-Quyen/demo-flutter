import 'package:flutter/material.dart';
import 'package:flutter_app/CounterBloc.dart';
import 'package:flutter_app/NavigateWidget.dart';
import 'package:provider/provider.dart';

class ThirdPageProvider extends StatefulWidget {
  const ThirdPageProvider();

  _ThirdPageProviderState createState() => _ThirdPageProviderState();
}

class _ThirdPageProviderState extends State<ThirdPageProvider> {
  @override
  Widget build(BuildContext context) {
    final counterBloc = Provider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ThirdPageProvider",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.teal,
        leading: NavigateWidget(context).backIconWidgetSetup(),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: counterBloc.counterList.length,
          itemBuilder: (context, position) {
            return itemList(counterBloc, position);
          },
        ),
      ),
    );
  }

  Widget itemList(CounterBloc counterBloc, int position) {
    return Dismissible(
      key: Key(UniqueKey().toString()),
      onDismissed: (direction) {
        counterBloc.removeItem(position);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.redAccent,
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 16,
              ),
            ),
            Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: Text(position.toString()),
            foregroundColor: Colors.white,
          ),
          title: Text(counterBloc.counterList[position]),
        ),
      ),
    );
  }
}
