import '../repositories/notes_repository.dart';

/// Caso de uso para eliminar una nota mediante su identificador.
///
/// Esta clase forma parte de la capa de dominio y encapsula la lógica
/// necesaria para eliminar una nota específica del repositorio.
class DeleteNote {
  /// Referencia al repositorio de notas, encargado del manejo de datos.
  final NotesRepository repository;

  /// Crea una instancia de [DeleteNote] con el repositorio dado.
  DeleteNote(this.repository);

  /// Ejecuta la eliminación de la nota con el identificador [id].
  ///
  /// Lanza una excepción si ocurre un error durante la operación.
  Future<void> call(int id) async {
    await repository.deleteNote(id);
  }
}
