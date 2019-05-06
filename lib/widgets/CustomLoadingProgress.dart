import 'package:flutter/material.dart';

class LoadingProgress extends Padding {
  LoadingProgress({Key key, bool isLoading})
      : super(
            key: key,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: Opacity(
                opacity: isLoading ? 1.0 : 0,
                child: CircularProgressIndicator(),
              ),
            ));
}
