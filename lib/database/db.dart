import 'dart:io';

import 'package:note/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final Db instance = Db._instance();

  static Database? _db = null;

  Db._instance();

  String noteTable = 'note_table';
  String calId = 'id';
  String calTitle = 'title';
  String calDate = 'date';
  String calPriority = 'priority';
  String calStatus = 'status';

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'note.list.db';
    final noteListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return noteListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $noteTable($calDate INTEGER PRIMARY KEY AUTOINCREMENT, $calTitle TEXT, $calDate TEXT, $calPriority TEXT, $calStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(noteTable);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    final List<Map<String, dynamic>> noteMapList = await getNoteMapList();
    final List<Note> noteList = [];
    noteMapList.forEach((noteMap) {
      noteList.add(Note.fromMap(noteMap));
    });
    noteList.sort((noteA, noteB) => noteA.date!.compareTo(noteB.date!));
    return noteList;
  }

  Future<int> insertNote(Note note) async {
    Database? db = await this.db;
    final int result = await db!.insert(
      noteTable,
      note.toMap(),
    );
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database? db = await this.db;
    final int result = await db!.update(
      noteTable,
      note.toMap(),
      where: '$calId = ?',
      whereArgs: [note.id],
    );
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(
      noteTable,
      where: '$calId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
