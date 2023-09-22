import 'package:offline_notes/models/notes_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class Notes {
  static void insertNotes(
    final String title,
    final String content,
  ) async {
    final db = await NotesTable.database;
    final id = const Uuid().v4();
    // Handles the creation of a note entity in app database
    await db!.insert(
      'notes',
      {
        'noteId': id,
        'title': title,
        'content': content,
        'dateCreated': DateTime.now().millisecondsSinceEpoch,
        'dateModified': DateTime.now().millisecondsSinceEpoch,
        'syncStatus': 'Unsynced',
        'version': 1,
        'isDeleted': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List> readNotes() async {
    final db = await NotesTable.database;
    // Query the table for all The notes.
    final List<Map<String, dynamic>> maps = await db!.query('notes');
    final notes = List.generate(
      maps.length,
      (i) {
        return {
          'noteId': maps[i]['noteId'],
          'title': maps[i]['title'],
          'syncStatus': maps[i]['syncStatus'],
          'isDeleted': maps[i]['isDeleted']
        };
      },
    );
    // returns notes that haven't been soft deleted.
    return notes.where((e) => e['isDeleted'] == 0).toList();
  }

  static Future<List> readNote(noteId) async {
    final db = await NotesTable.database;
    // Query the table for all The notes.
    final List<Map<String, dynamic>> maps = await db!.query('notes');
    List notes = List.generate(
      maps.length,
      (i) {
        return {
          'noteId': maps[i]['noteId'],
          'title': maps[i]['title'],
          'content': maps[i]['content'],
        };
      },
    );
    // Filter out the note that matches the specific notedId
    List note = notes.where((e) => e['noteId'] == noteId).toList();
    return note;
  }

  static Future<void> deleteNote(noteId) async {
    final db = await NotesTable.database;
    // updates the isDeleted to true
    final note = {'noteId': noteId, 'isDeleted': 1};
    await db!.update(
      'notes',
      note,
      where: 'noteId = ?',
      // Pass the note's id as a whereArg to prevent SQL injection.
      whereArgs: [noteId],
    );
  }

  static Future<void> updateNote(newNote) async {
    final db = await NotesTable.database;
    final note = {
      'noteId': newNote[0]['noteId'],
      'title': newNote[0]['title'],
      'content': newNote[0]['content']
    };
    await db!.update(
      'notes',
      note,
      where: 'noteId = ?',
      // Pass the note's id as a whereArg to prevent SQL injection.
      whereArgs: [newNote[0]['noteId']],
    );
  }
}
