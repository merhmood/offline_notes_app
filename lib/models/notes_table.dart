import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesTable {
  static final NotesTable instance = NotesTable._internal();
  static Future<Database>? database;

  factory NotesTable() {
    return instance;
  }

  NotesTable._internal();

  connect() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'distributed.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(noteId VARCHAR(255) PRIMARY KEY NOT NULL, title TEXT, content TEXT, dateCreated TEXT, dateModified TEXT, syncStatus VARCHAR(255), version INTEGER, isDeleted INTEGER)',
        );
      },
      version: 1,
    );
  }
}
