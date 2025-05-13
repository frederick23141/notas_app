import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

class GetNotes {
  final NotesRepository repository;

  GetNotes(this.repository);

  Future<List<NoteEntity>> call() async {
    return await repository.getNotes();
  }
}
