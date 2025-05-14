import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/core/constants/app_texts.dart';
import 'package:notas_app/features/notes/domain/usecases/add_note.dart'
    as usecase;
import 'package:notas_app/features/notes/domain/usecases/update_note.dart'
    as usecase;
import 'package:notas_app/features/notes/domain/usecases/delete_note.dart'
    as usecase;
import 'package:notas_app/features/notes/domain/usecases/get_notes.dart'
    as usecase;

import 'note_event.dart';
import 'note_state.dart';

/// BLoC que gestiona el estado y la lógica de negocio relacionada con las notas.
///
/// Este BLoC responde a eventos definidos en [NoteEvent] y emite estados
/// de tipo [NoteState] en función de los resultados de los casos de uso.
///
/// Maneja las operaciones de carga, adición, actualización y eliminación
/// de notas, actualizando el estado de la interfaz según corresponda.

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  /// Caso de uso para obtener todas las notas.
  final usecase.GetNotes getNotes;

  /// Caso de uso para agregar una nueva nota.
  final usecase.AddNote addNote;

  /// Caso de uso para actualizar una nota existente.
  final usecase.UpdateNote updateNote;

  /// Caso de uso para eliminar una nota por su identificador.
  final usecase.DeleteNote deleteNote;

  /// Crea una instancia de [NoteBloc] con los casos de uso necesarios.
  NoteBloc({
    required this.getNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NoteInitial()) {
    /// Maneja el evento de carga de notas.
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(AppTexts.errorLoadNotes));
      }
    });

    /// Maneja el evento de adición de una nueva nota.
    on<AddNote>((event, emit) async {
      try {
        await addNote(event.note);
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(AppTexts.errorAddNote));
      }
    });

    /// Maneja el evento de actualización de una nota existente.
    on<UpdateNote>((event, emit) async {
      try {
        await updateNote(event.note);
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(AppTexts.errorUpdateNote));
      }
    });

    /// Maneja el evento de eliminación de una nota.
    on<DeleteNote>((event, emit) async {
      try {
        await deleteNote(event.id);
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(AppTexts.errorDeleteNote));
      }
    });
  }
}
