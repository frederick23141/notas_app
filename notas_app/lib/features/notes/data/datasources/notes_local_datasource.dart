/*import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/note_entity.dart';

class NotesLocalDataSource {
  static final NotesLocalDataSource _instance =
      NotesLocalDataSource._internal();

  factory NotesLocalDataSource() => _instance;

  NotesLocalDataSource._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<NoteEntity>> getNotes() async {
    final dbClient = await db;
    final maps = await dbClient.query('notes');
    return maps
        .map(
          (e) => NoteEntity(
            id: e['id'] as int,
            title: e['title'] as String,
            content: e['content'] as String,
          ),
        )
        .toList();
  }

  Future<void> insertNote(NoteEntity note) async {
    final dbClient = await db;
    await dbClient.insert('notes', {
      'title': note.title,
      'content': note.content,
    });
  }

  Future<void> updateNote(NoteEntity note) async {
    final dbClient = await db;
    await dbClient.update(
      'notes',
      {'title': note.title, 'content': note.content},
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final dbClient = await db;
    await dbClient.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
*/
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notas_app/features/notes/domain/entities/note_entity.dart';

class NotesLocalDataSource {
  static Database? _database;

  // Inicializa la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Si no existe la base de datos, la creamos
    _database = await _initDB();
    return _database!;
  }

  // Crea o abre la base de datos
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
            content TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Guarda una nueva nota en la base de datos
  Future<void> saveNote(NoteEntity note) async {
    final db = await database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtiene todas las notas
  Future<List<NoteEntity>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return NoteEntity.fromMap(maps[i]);
    });
  }

  // Actualiza una nota
  Future<void> updateNote(NoteEntity note) async {
    final db = await database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Elimina una nota
  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
