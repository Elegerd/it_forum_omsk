import 'package:meta/meta.dart';


class Event {
  int id;
  final int idDay;
  final String nameEvent, timeSpending, location;
  bool chosen;

  Event({
    @required this.idDay,
    @required this.nameEvent,
    @required this.timeSpending,
    @required this.location,
    @required this.chosen,
  });

  Map <String, dynamic> toMap() {
    return {
      'idDay' : idDay,
      'nameEvent' : nameEvent,
      'timeSpending' : timeSpending,
      'location' : location,
      'chosen' : chosen,
    };
  }

  static Event fromMap(Map <String, dynamic> map) {
    return Event(
      idDay: map['idDay'],
      nameEvent: map['nameEvent'],
      timeSpending: map['timeSpending'],
      location: map['location'],
      chosen: map['chosen'],
    );
  }
}