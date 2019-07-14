import 'package:meta/meta.dart';


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