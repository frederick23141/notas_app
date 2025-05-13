import 'package:equatable/equatable.dart';
import '../../domain/entities/note_entity.dart';

abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final NoteEntity note;

  AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateNote extends NoteEvent {
  final NoteEntity note;

  UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote(this.id);

  @override
  List<Object?> get props => [id];
}
