import 'package:flutter/material.dart';


class EventContainer extends StatelessWidget {
  final event;
  const EventContainer(this.event);

  static const iconColor = Color.fromRGBO(123, 123, 130, 0.5);
  static const contentColor = Color.fromRGBO(31, 32, 65, 0.8);
  static const contentStyle = TextStyle(fontWeight: FontWeight.w400);
  static const titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: contentColor);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Material(
        color: Colors.white,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(2.0),
        textStyle: titleStyle,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 2),
                child: Text(event['name'] ?? ""),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        width: 2, color: Color.fromRGBO(124, 125, 141, 1),
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.location_on, color: iconColor, size: 28,),
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: 5),
                    child: Text(event['location'] ?? "Null", style: contentStyle),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.schedule, color: iconColor, size: 28,),
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: 5),
                    child: Text(event['time'] ?? "Null", style: contentStyle),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}