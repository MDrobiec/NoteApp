import 'package:note_app/const/const.dart';
import 'package:note_app/db/db_init.dart';
import 'package:note_app/model/notes.dart';
import 'package:sqflite/sqflite.dart';

class DBRequest {
  var databaseFuture = DatabaseHelper.db.database;

  Future<List<ModelNotes>> getAllNotes() async {
    late final List<ModelNotes> noteList;
    final Database database = await databaseFuture;
    final noteMap = await database.query(databaseTableName);
    noteList = noteMap.map((list) => ModelNotes.fromJson(list)).toList();
    return noteList;
  }

  Future<List<ModelNotes>> updateNote() async {
    late final List<ModelNotes> noteList;
    final Database database = await databaseFuture;
    return [];
  }

  Future<List<ModelNotes>> insertNote() async {
    late final List<ModelNotes> noteList;
    final Database database = await databaseFuture;
    return [];
  }

  Future<List<ModelNotes>> getFilterNote() async {
    late final List<ModelNotes> noteList;
    final Database database = await databaseFuture;
    return [];
  }
}
