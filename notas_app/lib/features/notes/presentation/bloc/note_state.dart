import 'package:equatable/equatable.dart';
import '../../domain/entities/note_entity.dart';

/// Clase base abstracta para representar los distintos estados del BLoC de notas.
///
/// Todas las clases de estado deben extender de [NoteState] para que el [NoteBloc]
/// pueda emitirlas correctamente.
abstract class NoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial del BLoC, antes de que se realice cualquier acción.
///
/// Generalmente se emite cuando se crea el BLoC por primera vez.
class NoteInitial extends NoteState {}

/// Estado que indica que las notas están siendo cargadas.
///
/// Se emite durante la ejecución de operaciones asincrónicas.
class NoteLoading extends NoteState {}

/// Estado que contiene la lista de notas una vez que fueron cargadas exitosamente.
class NoteLoaded extends NoteState {
  /// Lista de notas obtenidas del repositorio.
  final List<NoteEntity> notes;

  /// Crea una instancia de [NoteLoaded] con la lista de [notes] proporcionada.
  NoteLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

/// Estado que indica que ocurrió un error durante una operación relacionada con notas.
class NoteError extends NoteState {
  /// Mensaje que describe el error ocurrido.
  final String message;

  /// Crea una instancia de [NoteError] con el [message] proporcionado.
  NoteError(this.message);

  @override
  List<Object?> get props => [message];
}
