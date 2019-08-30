import 'package:flutter/material.dart';
import 'package:it_forum_omsk/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  static const mainColor = Color.fromRGBO(50, 21, 121, 1);

  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
          if (currentUser == null)
              Navigator.pushReplacementNamed(context, "/login")
          else {
            Firestore.instance
              .collection("users")
              .document(currentUser.uid)
              .get()
              .then((DocumentSnapshot result) =>
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(uid: currentUser.uid,)
                  ),
                )
              )
              .catchError((err) => print(err))
          }
        })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SpinKitFadingCube(
            color: mainColor,
            size: 80.0,
          ),
        ),
      ),
    );
  }
}