import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

/// Caso de uso para obtener la lista de notas desde el repositorio.
///
/// Esta clase forma parte de la capa de dominio y encapsula la lógica
/// necesaria para recuperar todas las notas almacenadas.
class GetNotes {
  /// Referencia al repositorio de notas, responsable de acceder a los datos.
  final NotesRepository repository;

  /// Crea una instancia de [GetNotes] con el repositorio proporcionado.
  GetNotes(this.repository);

  /// Recupera la lista completa de notas.
  ///
  /// Retorna una [List] de [NoteEntity] que representa las notas almacenadas.
  /// Lanza una excepción si ocurre un error durante la operación.
  Future<List<NoteEntity>> call() async {
    return await repository.getNotes();
  }
}
