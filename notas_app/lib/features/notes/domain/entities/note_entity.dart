/// Entidad que representa una nota.
///
/// Esta clase modela la estructura de una nota en la aplicación,
/// y se utiliza tanto para la lógica de negocio como para la persistencia
/// de datos en la base de datos local.
class NoteEntity {
  /// Identificador único de la nota. Puede ser nulo cuando se crea una nueva nota.
  final int? id;

  /// Título de la nota.
  final String title;

  /// Contenido o cuerpo de la nota.
  final String content;

  /// Fecha de creacion de la nota
  final DateTime date;

  final DateTime? dateupdate;

  /// Constructor de la entidad [NoteEntity].
  ///
  /// [id] es opcional, ya que una nueva nota puede no tener aún un ID asignado.
  /// [title] y [content] son requeridos.
  NoteEntity({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    this.dateupdate,
  });

  /// Convierte la instancia de [NoteEntity] en un mapa de clave-valor ([Map<String, dynamic>]),
  /// para ser almacenado en la base de datos.
  ///
  /// Esto permite insertar o actualizar la nota en una base de datos SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'dateupdate': dateupdate?.toIso8601String(),
    };
  }

  /// Crea una nueva instancia de [NoteEntity] a partir de un mapa
  /// de una consulta a la base de datos.
  ///
  /// Este método es útil para convertir los resultados obtenidos de SQLite
  /// en objetos manejables dentro de la aplicación.
  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      dateupdate:
          map['dateupdate'] != null ? DateTime.parse(map['dateupdate']) : null,
    );
  }
}
