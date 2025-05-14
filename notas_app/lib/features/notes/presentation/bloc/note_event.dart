import 'package:equatable/equatable.dart';
import '../../domain/entities/note_entity.dart';

/// Clase base abstracta para todos los eventos relacionados con notas.
///
/// Todos los eventos deben extender de esta clase para ser procesados
/// por el [NoteBloc]. Implementa [Equatable] para facilitar la comparación
/// entre instancias.
abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Evento para solicitar la carga de todas las notas.
///
/// Este evento suele ser emitido cuando la aplicación inicia o
/// se desea refrescar la lista de notas.
class LoadNotes extends NoteEvent {}

/// Evento para agregar una nueva nota.
///
/// Contiene una instancia de [NoteEntity] que representa la nota a agregar.
class AddNote extends NoteEvent {
  /// La nota que se desea agregar.
  final NoteEntity note;

  /// Crea una instancia de [AddNote] con la nota proporcionada.
  AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

/// Evento para actualizar una nota existente.
///
/// Contiene una instancia de [NoteEntity] con los datos actualizados.
class UpdateNote extends NoteEvent {
  /// La nota que se desea actualizar.
  final NoteEntity note;

  /// Crea una instancia de [UpdateNote] con la nota actualizada.
  UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

/// Evento para eliminar una nota a partir de su identificador.
///
/// Contiene el [id] de la nota que se desea eliminar.
class DeleteNote extends NoteEvent {
  /// Identificador de la nota a eliminar.
  final int id;

  /// Crea una instancia de [DeleteNote] con el id proporcionado.
  DeleteNote(this.id);

  @override
  List<Object?> get props => [id];
}
