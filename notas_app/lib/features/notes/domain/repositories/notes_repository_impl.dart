import 'package:notas_app/features/notes/data/datasources/notes_local_datasource.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';

/// Implementación concreta del repositorio de notas.
///
/// Esta clase actúa como intermediaria entre la capa de dominio
/// y la fuente de datos local, encapsulando la lógica de acceso
/// a datos y permitiendo cambiar la fuente de datos sin afectar
/// a la capa de negocio.
class NotesRepositoryImpl implements NotesRepository {
  /// Fuente de datos local utilizada para persistir y recuperar notas.
  final NotesLocalDataSource localDataSource;

  /// Constructor que recibe la fuente de datos local.
  NotesRepositoryImpl(this.localDataSource);

  /// Obtiene todas las notas almacenadas localmente.
  ///
  /// Devuelve una lista de [NoteEntity] que representa las notas existentes.
  @override
  Future<List<NoteEntity>> getNotes() async {
    return await localDataSource.getNotes();
  }

  /// Agrega una nueva nota a la base de datos local.
  ///
  /// [note] es la instancia de [NoteEntity] que se desea guardar.
  @override
  Future<void> addNote(NoteEntity note) async {
    await localDataSource.saveNote(note);
  }

  /// Actualiza una nota existente en la base de datos local.
  ///
  /// [note] debe contener el `id` de la nota a modificar.
  @override
  Future<void> updateNote(NoteEntity note) async {
    await localDataSource.updateNote(note);
  }

  /// Elimina una nota de la base de datos local según su ID.
  ///
  /// [id] es el identificador único de la nota a eliminar.
  @override
  Future<void> deleteNote(int id) async {
    await localDataSource.deleteNote(id);
  }
}
