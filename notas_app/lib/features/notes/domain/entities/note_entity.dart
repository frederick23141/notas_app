/*import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int? id;
  final String title;
  final String content;

  const NoteEntity({this.id, required this.title, required this.content});

  @override
  List<Object?> get props => [id, title, content];
}
*/
class NoteEntity {
  final int? id;
  final String title;
  final String content;

  NoteEntity({this.id, required this.title, required this.content});

  // Convertir la nota en un Map para guardar en la base de datos
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content};
  }

  // Convertir un Map de la base de datos a una instancia de Note
  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
