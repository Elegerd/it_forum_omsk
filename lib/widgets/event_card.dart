import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it_forum_omsk/widgets/speaker_container.dart';


class EventCard extends StatelessWidget {
  final event;
  const EventCard(this.event);

  static const iconColor = Color.fromRGBO(123, 123, 130, 0.5);
  static const textColor = Color.fromRGBO(69, 69, 77, 1);
  static const buttonColor = Color.fromRGBO(65, 195, 0, 1);
  static const infoStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300, fontFamily: 'Roboto', color: textColor);
  static const contentStyle = TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: textColor);
  static const titleStyle = TextStyle(fontSize: 30, height: 1.2, fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: textColor);
  static const buttonStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Roboto', color: Colors.white, letterSpacing: 1);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          _eventName(context),
          _eventInfo(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(event['note'] ?? "", style: contentStyle,),
          ),
          event['id_speaker'] == null ?
            SizedBox() : StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance.collection('speakers').document('document_speakers').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                var speaker = snapshot.data.data['array_speakers'][event['id_speaker']];
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return SpeakerContainer(speaker, 0);
                }
              },
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            height: 80,
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Text("Добавить в моё расписание", textAlign: TextAlign.center, style: buttonStyle,)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventName(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: iconColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(event['name'] ?? "",
                style: titleStyle,),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventInfo() {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(Icons.schedule, size: 28, color: iconColor),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("${event['date'] ?? "Null"}\n${event['time'] ?? "Null"}", style: infoStyle,)
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on, size: 28, color: iconColor),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(event['location'] ?? "Null", style: infoStyle,)
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}