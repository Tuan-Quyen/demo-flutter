import 'package:flutter/material.dart';
import 'package:flutter_app/network/Url.dart';
import 'widgets/CustomAppBar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/responses/ResponseUserImage.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'dart:async';

class ImageLoadPage extends StatelessWidget {
  List<ResponseUserImage> _imageList = new List();

  Future<List<ResponseUserImage>> getImage() async {
    final res = await http.get(BaseUrl.userImage());
    if (res.statusCode == 200) {
      var rest = json.decode(res.body)["items"] as List;
      print(rest.toString());
      List<ResponseUserImage> data = rest
          .map<ResponseUserImage>((json) => ResponseUserImage.fromJson(json))
          .toList();
      _imageList.addAll(data);
      return null;
    }
  }

  Container _itemView(int position) {
    return Container(
        width: 100,
        height: 100,
        child: TransitionToImage(
          image: AdvancedNetworkImage(_imageList[position].profileImage,
              timeoutDuration: Duration(milliseconds: 2000),
              useDiskCache: true,
              cacheRule: CacheRule(maxAge: const Duration(milliseconds: 3000))),
          width: 50,
          height: 50,
          placeholder: Icon(Icons.error),
          loadingWidget: Center(
            child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Image Loader",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        color: Colors.lightBlue,
        hasLeft: false,
        hasRight: true,
        context: context,
        navigatorRoute: "/QuestionPage",
      ),
      body: Container(
        child: FutureBuilder(
            future: getImage(),
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
                    return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemCount: _imageList.length,
                        itemBuilder: (context, position) {
                          return _itemView(position);
                        });
                  }
              }
            }),
      ),
    );
  }
}
