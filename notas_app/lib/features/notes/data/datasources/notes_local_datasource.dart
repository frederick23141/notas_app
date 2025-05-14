import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notas_app/features/notes/domain/entities/note_entity.dart';

/// Repositorio local de notas utilizando SQLite.
///
/// Esta clase proporciona métodos para interactuar con la base de datos local SQLite
/// para realizar operaciones CRUD (Crear, Leer, Actualizar y Eliminar) sobre las notas.
/// Los datos de las notas se almacenan en una base de datos SQLite llamada "notes.db".
class NotesLocalDataSource {
  static Database? _database;

  /// Obtiene una instancia de la base de datos. Si la base de datos no existe, se crea.
  ///
  /// Utiliza una base de datos singleton para garantizar que solo exista una instancia
  /// de la base de datos durante la vida útil de la aplicación.
  // Inicializa la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Si no existe la base de datos, la creamos
    _database = await _initDB();
    return _database!;
  }

  /// Inicializa la base de datos y crea la tabla 'notes' si no existe.
  ///
  /// Si la base de datos no existe, se crea y se establece la estructura de las tablas.
  ///
  /// Devuelve una instancia de [Database] una vez que se ha abierto o creado la base de datos.
  Future<Database> _initDB() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'notes.db'),
      onCreate: (db, version) async {
        // Crea la tabla de notas
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            date TEXT,
            dateupdate TEXT
          )
        ''');
      },
      version: 2,
    );
  }

  /// Guarda una nueva nota en la base de datos.
  ///
  /// Inserta una nueva nota en la tabla 'notes'. Si la nota ya existe, se reemplaza.
  ///
  /// Parámetro:
  /// - [note]: La nota a guardar, que debe ser una instancia de [NoteEntity].
  Future<void> saveNote(NoteEntity note) async {
    final db = await database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtiene todas las notas almacenadas en la base de datos.
  ///
  /// Consulta la tabla 'notes' y devuelve una lista de objetos [NoteEntity].
  ///
  /// Devuelve:
  /// - Una lista de [NoteEntity] que contiene todas las notas almacenadas.
  Future<List<NoteEntity>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return NoteEntity.fromMap(maps[i]);
    });
  }

  /// Actualiza una nota existente en la base de datos.
  ///
  /// Modifica los valores de la nota en la base de datos utilizando el ID como referencia.
  ///
  /// Parámetro:
  /// - [note]: La nota que se va a actualizar, debe ser una instancia de [NoteEntity].
  /*Future<void> updateNote(NoteEntity note) async {
    final db = await database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
  */
  Future<void> updateNote(NoteEntity note) async {
    final db = await database;

    // Crear un mapa con los campos a actualizar, incluyendo 'dteupdate' con la fecha actual
    final Map<String, dynamic> noteMap = {
      'title': note.title,
      'content': note.content,
      'dateupdate':
          DateTime.now()
              .toIso8601String(), // Capturamos la fecha de actualización
    };

    // Realizamos la actualización con los campos que queremos cambiar
    await db.update('notes', noteMap, where: 'id = ?', whereArgs: [note.id]);
  }

  /// Elimina una nota de la base de datos.
  ///
  /// Elimina la nota de la tabla 'notes' según el ID de la misma.
  ///
  /// Parámetro:
  /// - [id]: El ID de la nota que se desea eliminar.
  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
