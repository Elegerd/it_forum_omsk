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


class Speaker {
  int id;
  final String firstName, lastName, middleName;
  final String note;
  final List<int> idEvent;

  Speaker({
    @required this.firstName,
    @required this.lastName,
    @required this.middleName,
    @required this.note,
    @required this.idEvent,
  });

  Map <String, dynamic> toMap() {
    return {
      'firstName' : firstName,
      'lastName' : lastName,
      'middleName' : middleName,
      'note' : note,
      'idEvent' : idEvent,
    };
  }

  static Speaker fromMap(Map <String, dynamic> map) {
    return Speaker(
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleName: map['middleName'],
      note: map['note'],
      idEvent: map['idEvent'].cast<int>(),
    );
  }
}