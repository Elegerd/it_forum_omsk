import 'package:sembast/sembast.dart';
import 'package:it_forum_omsk/repositories/app_database.dart';
import 'package:it_forum_omsk/models/model_event.dart';
import 'package:it_forum_omsk/models/model_speaker.dart';


class DBLogicEvent {
  static const String store = 'events';
  final _events = intMapStoreFactory.store(store);

  Future<Database> get db async => await EventDB.instance.db;

  Future insert(Event event) async {
    await _events.add(await db, event.toMap());
  }

  Future update(Event event) async {
    final finder = Finder(filter: Filter.byKey(event.id));
    await _events.update(
      await db,
      event.toMap(),
      finder: finder,
    );
  }

  Future modifySelectedEvent(Event event) async {
    final finder = Finder(filter: Filter.byKey(event.id));
    event.chosen = !event.chosen;

    await _events.update(
      await db,
      event.toMap(),
      finder: finder,
    );
  }

  Future delete(Event event) async {
    final finder = Finder(filter: Filter.byKey(event.id));
    await _events.delete(
      await db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _events.delete(
      await db,
    );
  }

  Future isEmptyEvents() async {
    final snapshot = await _events.find(await db);
    return snapshot.isEmpty;
  }

  Future<List<Event>> getAllEvents() async {
    final snapshot = await _events.find(await db);
    return snapshot.map((map) {
      final event = Event.fromMap(map.value);
      event.id = map.key;
      return event;
    }).toList();
  }

  Future<List<Event>> getFavoriteEvents() async {
    final snapshot = await _events.find(await db);
    return snapshot.map((map) {
      final event = Event.fromMap(map.value);
      event.id = map.key;
      return event;
    }).where((event) => event.chosen).toList();
  }

  Future<List<Event>> getSpeakerEvents(List<int> listId) async {
    final snapshot = await _events.find(await db);
    return snapshot.map((map) {
      final event = Event.fromMap(map.value);
      event.id = map.key;
      return event;
    }).where((event) => listId.contains(event.id)).toList();
  }

  Future<List<Event>> getEvents(int idDay) async {
    final snapshot = await _events.find(await db);
    return snapshot.map((map) {
      final event = Event.fromMap(map.value);
      event.id = map.key;
      return event;
    }).where((event) => event.idDay == idDay).toList();
  }
}

class DBLogicSpeaker {
  static const String store = 'speakers';
  final _speakers = intMapStoreFactory.store(store);

  Future<Database> get db async => await SpeakerDB.instance.db;

  Future insert(Speaker speaker) async {
    await _speakers.add(await db, speaker.toMap());
  }

  Future update(Speaker speaker) async {
    final finder = Finder(filter: Filter.byKey(speaker.id));
    await _speakers.update(
      await db,
      speaker.toMap(),
      finder: finder,
    );
  }

  Future delete(Speaker speaker) async {
    final finder = Finder(filter: Filter.byKey(speaker.id));
    await _speakers.delete(
      await db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _speakers.delete(
      await db,
    );
  }

  Future isEmptySpeakers() async {
    final snapshot = await _speakers.find(await db);
    return snapshot.isEmpty;
  }

  Future<List<Speaker>> getAllSpeakers () async {
    final snapshot = await _speakers.find(await db);
    return snapshot.map((map) {
      final speaker = Speaker.fromMap(map.value);
      speaker.id = map.key;
      return speaker;
    }).toList();
  }
}