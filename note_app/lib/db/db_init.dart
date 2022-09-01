import 'package:path/path.dart' as p;

import 'package:note_app/const/db_const.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._instance();

  static final DatabaseHelper db = DatabaseHelper._instance();
  late Database _database;

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var directory = await getDatabasesPath();
    String path = p.join(directory, databaseName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(scriptGenerateNoteTable);
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }
}
