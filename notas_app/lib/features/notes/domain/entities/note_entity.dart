import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int? id;
  final String title;
  final String content;

  const NoteEntity({this.id, required this.title, required this.content});

  @override
  List<Object?> get props => [id, title, content];
}
