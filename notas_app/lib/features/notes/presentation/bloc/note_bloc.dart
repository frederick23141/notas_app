import 'package:flutter_bloc/flutter_bloc.dart';
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

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  /* final GetNotes getNotes;
  final AddNote addNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;
*/
  final usecase.GetNotes getNotes;
  final usecase.AddNote addNote;
  final usecase.UpdateNote updateNote;
  final usecase.DeleteNote deleteNote;

  NoteBloc({
    required this.getNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError('Error al cargar notas'));
      }
    });

    on<AddNote>((event, emit) async {
      try {
        await addNote(event.note);
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError('Error al agregar nota'));
      }
    });

    on<UpdateNote>((event, emit) async {
      try {
        await updateNote(event.note);
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError('Error al actualizar nota'));
      }
    });

    on<DeleteNote>((event, emit) async {
      try {
        await deleteNote(event.id);
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError('Error al eliminar nota'));
      }
    });
  }
}
