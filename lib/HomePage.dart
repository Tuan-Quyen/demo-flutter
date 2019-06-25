import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Profile.dart';
import 'UserPage.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  var facebookLogin = FacebookLogin();
  Profile _profile;
  String token = "";

  @override
  void initState() {
    if(_auth.currentUser() != null){
      getUser();
    }
  }

  Future getUser() async {
    FirebaseUser user = await _auth.currentUser();
    _profile = new Profile(
        name: user.displayName,
        email: user.email,
        id: user.providerId,
        picture: "");
    print(user.email);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => UserPage(
          profile: _profile,
        )));
  }

  void initiateFacebookLogin() async {
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    var result = await facebookLogin
        .logInWithReadPermissions(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        token = result.accessToken.token;
        final AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: token);
        final FirebaseUser user = await _auth.signInWithCredential(credential);
        print("user email: " + user.email);
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(300).width(300)&access_token=${token}');
        print("grap : " + graphResponse.body);
        _profile = Profile.fromJson(json.decode(graphResponse.body));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => UserPage(
                  profile: _profile,
                )));
        break;
    }
  }

  void loginGoogle() async {
    GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication =
        await signInAccount.authentication;
    print(signInAuthentication.accessToken);
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken);
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print(user.email);
    _profile = new Profile(
        name: signInAccount.displayName,
        email: signInAccount.email,
        id: signInAccount.id,
        picture: signInAccount.photoUrl);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => UserPage(
              profile: _profile,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  "Flutter",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.lightBlue[300],
                        )
                      ]),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  constraints: BoxConstraints.expand(height: 50),
                  child: RaisedButton(
                      child: const Text(
                        "Sign in with facebook",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      splashColor: Colors.blueGrey,
                      textColor: Colors.lightBlue,
                      color: Colors.white,
                      onPressed: () {
                        initiateFacebookLogin();
                      })),
              Container(
                  margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  constraints: BoxConstraints.expand(height: 50),
                  child: RaisedButton(
                      child: const Text(
                        "Sign in with google",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      splashColor: Colors.blueGrey,
                      textColor: Colors.lightBlue,
                      color: Colors.white,
                      onPressed: () {
                        loginGoogle();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
