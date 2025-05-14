import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

/// Caso de uso para agregar una nota a través del repositorio.
///
/// Esta clase representa una acción dentro de la capa de dominio
/// que encapsula la lógica de agregar una nueva nota a la fuente de datos.
class AddNote {
  /// Referencia al repositorio de notas, que define las operaciones de acceso a datos.
  final NotesRepository repository;

  /// Crea una instancia de [AddNote] con el repositorio proporcionado.
  AddNote(this.repository);

  /// Ejecuta el caso de uso para agregar una [note] usando el repositorio.
  ///
  /// Lanza una excepción si ocurre un error durante la operación.
  Future<void> call(NoteEntity note) async {
    await repository.addNote(note);
  }
}
