import 'package:sqflite/sqflite.dart';
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
