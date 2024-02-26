import 'package:sqflite/sqflite.dart';

import 'models/note_model.dart';

Database? db;

class DataBaseHelper {
  static const String tableName = "note";

  static Future<void> addNote (NoteModel noteModel) async {
     await db!.insert(tableName, noteModel.toMap());
   // final response = await db!.query(tableName,orderBy: "priority ASC");
    //print(response);
   // print("here");
  }
  static Future<void> updateNote (NoteModel noteModel) async {
   await  db!.update(
       tableName,
     noteModel.toMap(),
     where: "id = ?",
     whereArgs: [noteModel.id],
   );
  }
  static Future<void> deleteNote (NoteModel noteModel) async {
    await  db!.delete(
      tableName,
      where: "id = ?",
      whereArgs: [noteModel.id],
    );
  }
   Future<List<NoteModel>> getNotes () async {
    try{
      final List<Map<String, Object?>> response = await db!.query(tableName,orderBy: "priority ASC");
      print(response[0]);
      print("here123");
      //var list = NoteModel.fromMap(response[0] as Map<String,dynamic>);
      print("list");
      //print(list.toString());
      List<NoteModel> notes = [];
      for(int i = 0 ; i<response.length;i++)
      {
        notes.add(NoteModel.fromMap(response[i] as Map<String,dynamic>));
      }
      print(notes.toString());
      return notes;
      //return response.map((e) => NoteModel.fromMap(e as Map<String,Object>)).toList();
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }
}
