import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class EventButton extends StatefulWidget {
  final int idEvent;
  final String idDocument;
  const EventButton(this.idEvent, this.idDocument);

  @override
  _EventButton createState() => _EventButton();
}

class _EventButton extends State<EventButton> {

  var buttonColor;
  var buttonTitle;

  static const buttonColorSet = Color.fromRGBO(65, 195, 0, 1);
  static const buttonColorDelete = Color.fromRGBO(205, 92, 92, 1);
  static const buttonStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Roboto', color: Colors.white, letterSpacing: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setStore(favourite) {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
          Firestore.instance
            .collection('users')
            .document(currentUser.uid)
            .collection('featured_events')
            .document(widget.idDocument)
            .setData({
              '${widget.idEvent}': {'favourite' : favourite},
            }, merge: true)
        });
  }

  void setValue(favourite) {
    if (favourite) {
      buttonColor = buttonColorDelete;
      buttonTitle = "Удалить из избранного";
    }
    else {
      buttonColor = buttonColorSet;
      buttonTitle = "Добавить в избранное";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user){
        return StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
                    .collection('users')
                    .document(user.data.uid)
                    .collection('featured_events')
                    .document(widget.idDocument).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            var favourite = false;
            try {
              favourite = snapshot.data['${widget.idEvent}']['favourite'];
            } catch(_) {
              favourite = false;
            }
            setValue(favourite);
            return GestureDetector(
              onTap: () {
                setStore(!favourite);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                height: 80,
                child: Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text(buttonTitle, textAlign: TextAlign.center, style: buttonStyle,)
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}