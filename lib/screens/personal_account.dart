import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/custom_appbar.dart';


class PersonalAccount extends StatelessWidget {
  final String title;
  final keyState;
  PersonalAccount(this.title, this.keyState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      body: Column(
        children: <Widget>[
          CustomAppBar(title, 100, keyState),
        ],
      ),
    );
  }
}