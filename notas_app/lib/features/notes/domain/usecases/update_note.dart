import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

/// Caso de uso para actualizar una nota existente en el repositorio.
///
/// Esta clase pertenece a la capa de dominio y encapsula la lógica
/// necesaria para modificar una nota previamente guardada.
class UpdateNote {
  /// Referencia al repositorio de notas, encargado de manejar los datos.
  final NotesRepository repository;

  /// Crea una instancia de [UpdateNote] con el repositorio proporcionado.
  UpdateNote(this.repository);

  /// Ejecuta la actualización de la [note] proporcionada.
  ///
  /// Lanza una excepción si ocurre un error durante la operación.
  Future<void> call(NoteEntity note) async {
    await repository.updateNote(note);
  }
}
