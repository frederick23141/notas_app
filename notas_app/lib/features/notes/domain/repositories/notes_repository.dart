import '../entities/note_entity.dart';

/// Contrato abstracto para el repositorio de notas.
///
/// Define las operaciones que deben ser implementadas para manejar
/// la persistencia de notas en la aplicación. Esta abstracción permite
/// cambiar la fuente de datos (local, remota, etc.) sin afectar
/// a la lógica de negocio que utiliza estas operaciones.
abstract class NotesRepository {
  /// Obtiene la lista de todas las notas disponibles.
  ///
  /// Devuelve una lista de [NoteEntity] con las notas almacenadas.
  Future<List<NoteEntity>> getNotes();

  /// Agrega una nueva nota al almacenamiento.
  ///
  /// [note] es la instancia de [NoteEntity] que se desea guardar.
  Future<void> addNote(NoteEntity note);

  /// Actualiza una nota existente.
  ///
  /// [note] debe incluir el identificador de la nota que se desea actualizar.
  Future<void> updateNote(NoteEntity note);

  /// Elimina una nota específica mediante su [id].
  ///
  /// [id] representa el identificador único de la nota a eliminar.
  Future<void> deleteNote(int id);
}
