import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/speaker_avatar.dart';
import 'package:it_forum_omsk/widgets/speaker_note.dart';


class SpeakerCard extends StatelessWidget {
  final int idSpeaker;
  final speaker;
  SpeakerCard(this.speaker, this.idSpeaker);

  static const iconColor = Color.fromRGBO(123, 123, 130, 0.5);
  static const titleColor = Color.fromRGBO(69, 69, 77, 1);
  static const titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w500, fontFamily: 'Roboto', color: titleColor);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _speakerName(context),
          Expanded(
            child: SpeakerNote(speaker, idSpeaker)
          ),
        ],
      ),
    );
  }

  Widget _speakerName(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
      child: Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: iconColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Center(
            child: Column(
              children: <Widget>[
                SpeakerAvatar(speaker['avatar'], 100),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("${speaker['last_name'] ?? ""} ${speaker['first_name'] ?? ""} ${speaker['middle_name'] ?? ""}",
                      style: titleStyle,
                      textAlign: TextAlign.center
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}