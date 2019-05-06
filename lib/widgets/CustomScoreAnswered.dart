import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.all(10),
          width: 100,
          color: _voteColorBg(isAnswered),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    score.toString(),
                    style: TextStyle(
                        color: _voteColorNumber(isAnswered),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      answered.toString(),
                      style: TextStyle(
                          color: _voteColorNumber(isAnswered),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'lib/images/ic_vote.png',
                      width: 20,
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: _voteImage(answered, isAnswered),
                    )
                  ],
                ),
              )
            ],
          ),
        );
}
