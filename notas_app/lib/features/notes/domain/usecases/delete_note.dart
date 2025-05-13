import '../repositories/notes_repository.dart';

class DeleteNote {
  final NotesRepository repository;

  DeleteNote(this.repository);

  Future<void> call(int id) async {
    await repository.deleteNote(id);
  }
}
