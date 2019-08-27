import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/speaker_avatar.dart';


class SpeakerContainer extends StatelessWidget {
  final speaker;
  final double elevation;
  const SpeakerContainer(this.speaker, this.elevation);

  static const contentColor = Color.fromRGBO(31, 32, 65, 0.8);
  static const titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: contentColor);
  static const contentStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300, fontFamily: 'Roboto', color: contentColor);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Material(
        color: Colors.white,
        elevation: elevation,
        borderRadius: BorderRadius.circular(2.0),
        textStyle: contentStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
              child: SpeakerAvatar(speaker['avatar'], 33),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("${speaker['last_name'] ?? ""} ${speaker['first_name'] ?? ""} ${speaker['middle_name'] ?? ""}", style: titleStyle,)
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(speaker['note'] ?? ""),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}