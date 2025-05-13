import 'package:notas_app/features/notes/data/datasources/notes_local_datasource.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource localDataSource;

  NotesRepositoryImpl(this.localDataSource);

  @override
  Future<List<NoteEntity>> getNotes() async {
    return await localDataSource.getNotes();
  }

  @override
  Future<void> addNote(NoteEntity note) async {
    await localDataSource.saveNote(note);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    await localDataSource.updateNote(note);
  }

  @override
  Future<void> deleteNote(int id) async {
    await localDataSource.deleteNote(id);
  }
}
