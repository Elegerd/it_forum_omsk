import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';


class EventDB {

  EventDB._internal();

  static EventDB get instance => _singleton;
  static final EventDB _singleton = EventDB._internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _openDB();
    return _db;
  }

  Future _openDB() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'event.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}

class SpeakerDB {

  SpeakerDB._internal();

  static SpeakerDB get instance => _singleton;
  static final SpeakerDB _singleton = SpeakerDB._internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _openDB();
    return _db;
  }

  Future _openDB() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'speaker.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}