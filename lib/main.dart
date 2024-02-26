import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_notes_with_sqlite/screens/home_screen.dart';

import 'data_base_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(db == null)
    {
     await initializeDatabase();
    }
  runApp(const MyApp());
}
initializeDatabase() async {
  db = await openDatabase("note.db",version: 1,onCreate: _createDb);
}
void _createDb (Database db , int newVersion) async {
  await db.execute(
            "create table note (id integer primary key autoincrement,title text, description text,createAt text,priority text)"
        );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}



