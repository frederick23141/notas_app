import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

class AddNote {
  final NotesRepository repository;

  AddNote(this.repository);

  Future<void> call(NoteEntity note) async {
    await repository.addNote(note);
  }
}
