import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Profile.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'HomePage.dart';

class UserPage extends StatefulWidget {
  final Profile profile;

  const UserPage({Key key, this.profile}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var facebookLogin = FacebookLogin();
  GoogleSignIn signInAccount = GoogleSignIn();

  Future<Null> _signOut() async {
    bool isSignedGoogle = await signInAccount.isSignedIn();
    bool isSignedFB = await facebookLogin.isLoggedIn;
    if (isSignedGoogle) {
      signInAccount.signOut();
    } else if (isSignedFB) {
      facebookLogin.logOut();
    }
    _auth.signOut().then((value){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()));
    });

    /*bool isSignedGoogle = await signInAccount.isSignedIn();
    if (isSignedGoogle) {
      await signInAccount.signOut().then((value) {
        print("logout google");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else if (facebookLogin.currentAccessToken != null) {
      await facebookLogin.logOut().then((value) {
        print("logout facebook");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    print(widget.profile.picture);
    return Scaffold(
      appBar: AppBar(
        title: Text("User Page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(widget.profile.name),
            Text(widget.profile.email),
            Text(widget.profile.id),
            /*Image.network(
              widget.profile.picture,
              fit: BoxFit.fill,
              width: 200,
              height: 200,
            )*/
            Container(
                margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                constraints: BoxConstraints.expand(height: 50),
                child: RaisedButton(
                    child: const Text(
                      "Sign in with facebook",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    splashColor: Colors.blueGrey,
                    textColor: Colors.lightBlue,
                    color: Colors.white,
                    onPressed: () {
                      _signOut();
                    }))
          ],
        ),
      ),
    );
  }
}
