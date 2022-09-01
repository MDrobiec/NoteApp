import 'package:flutter/foundation.dart';
import 'package:note_app/const/const.dart';
import 'package:note_app/db/db_init.dart';
import 'package:note_app/model/notes.dart';
import 'package:sqflite/sqflite.dart';

class DBRequest {
  var databaseFuture = DatabaseHelper.db.database;

  Future<List<ModelNotes>> getAllNotes(date, state1, state2, state0) async {
    late final List<ModelNotes> noteList;
    final Database database = await databaseFuture;
    final noteMap = await database.query(
      databaseTableName,
      where: "DATE(note_date) = ? and state in (?,?,?)",
      whereArgs: [date, state1, state2, state0],
      orderBy: "note_id DESC",
    );
    noteList = noteMap.map((list) => ModelNotes.fromJson(list)).toList();
    return noteList;
  }

  Future<List<ModelNotes>> getOneNotes(id) async {
    late final List<ModelNotes> noteList;
    final Database database = await databaseFuture;
    final noteMap = await database.query(
      databaseTableName,
      where: 'note_id = ?',
      whereArgs: [id],
      orderBy: "note_id DESC",
    );
    noteList = noteMap.map((list) => ModelNotes.fromJson(list)).toList();
    return noteList;
  }

  Future<int> updateNote(id) async {
    final Database database = await databaseFuture;
    int row = await database
        .rawUpdate('UPDATE note SET state = 2 WHERE note_id = ?', [id]);
    return row;
  }

  Future<int> updateNoteOne(id, noteName, noteContext) async {
    final Database database = await databaseFuture;
    int row = await database.rawUpdate(
        'UPDATE note SET state = 1,note_name = ?,contents = ? WHERE note_id = ?',
        [noteName, noteContext, id]);
    return row;
  }

  Future<List<ModelNotes>> insertNote(List<ModelNotes> noteList) async {
    final Database database = await databaseFuture;
    Batch batch = database.batch();
    try {
      noteList.forEach((element) async {
        batch.insert(databaseTableName, element.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      });
      batch.commit();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return [];
  }

  Future<List<ModelNotes>> getFilterNote() async {
    late final List<ModelNotes> noteList;
    final Database database = await databaseFuture;
    return [];
  }
}
