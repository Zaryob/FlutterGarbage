import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteProvider{
  static Database db;

  static Future open() async{
    db = await openDatabase(
        join(await getDatabasesPath(), 'notes.db'),
      version: 1,
        onCreate: (Database db, int version) async{
           db.execute('''
          CREATE TABLE Notes(id INTEGER PRIMARY KEY,title TEXT,text TEXT);
          ''');
        }
    );
  }
  static Future<List<Map<String, dynamic>>> getNoteList() async{
    if(db==null){
      await open();
    }
    return await db.query('Notes');
  }
  static Future insertNote(Map<String, dynamic> note) async{
    await db.insert(
        'Notes',
        note
    );
  }
  static Future uptadeNote(Map<String, dynamic> note) async{
    await db.update(('Notes'), note,
        where:'id=?',
        whereArgs: [note['id']]);
  }
  static Future deleteNote(int id) async{
    await db.delete(
        'Notes',
        where: 'id=?',
        whereArgs: [id]
    );
  }
}