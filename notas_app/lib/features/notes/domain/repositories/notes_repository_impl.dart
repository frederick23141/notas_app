import 'package:notas_app/features/notes/data/datasources/notes_local_datasource.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource dataSource;

  NotesRepositoryImpl(this.dataSource);

  @override
  Future<void> addNote(NoteEntity note) => dataSource.insertNote(note);

  @override
  Future<void> deleteNote(int id) => dataSource.deleteNote(id);

  @override
  Future<List<NoteEntity>> getNotes() => dataSource.getNotes();

  @override
  Future<void> updateNote(NoteEntity note) => dataSource.updateNote(note);
}
