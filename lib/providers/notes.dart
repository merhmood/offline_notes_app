import 'package:offline_notes/models/notes.dart';

class NotesProvider {
  addNotes(title, content) {
    Notes.insertNotes(title, content);
  }

  Future<List> getNotes() async {
    final notes = await Notes.readNotes();
    return notes;
  }

  Future<List> getNote(id) async {
    final note = await Notes.readNote(id);
    return note;
  }

  Future<void> deletetNote(id) async {
    await Notes.deleteNote(id);
  }

  Future<void> updateNote(newNote) async {
    await Notes.updateNote(newNote);
  }
}
