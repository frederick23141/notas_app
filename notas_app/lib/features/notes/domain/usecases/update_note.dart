import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

class UpdateNote {
  final NotesRepository repository;

  UpdateNote(this.repository);

  Future<void> call(NoteEntity note) async {
    await repository.updateNote(note);
  }
}
