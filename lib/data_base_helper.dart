import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'models/note_model.dart';

Database? db;

class DataBaseHelper {
  static const String tableName = "note";

  static Future<void> addNote (NoteModel noteModel) async {
    try{
      await db!.insert(tableName, noteModel.toMap());
    }catch(e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  static Future<void> updateNote (NoteModel noteModel) async {
    try{
      await  db!.update(
        tableName,
        noteModel.toMap(),
        where: "id = ?",
        whereArgs: [noteModel.id],
      );
    }catch(e) {
      debugPrint(e.toString());
      rethrow;
    }

  }
  static Future<void> deleteNote (NoteModel noteModel) async {
    try{
      await  db!.delete(
        tableName,
        where: "id = ?",
        whereArgs: [noteModel.id],
      );
    }catch(e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
   Future<List<NoteModel>> getNotes () async {
    try{
      final List<Map<String, Object?>> response = await db!.query(tableName,orderBy: "priority ASC");
      return response.map((e) => NoteModel.fromMap(e as Map<String,Object>)).toList();
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }
}
