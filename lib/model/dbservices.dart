import 'package:quaran_app/model/notesmodel.dart';
import 'package:sqflite/sqflite.dart';

class Dbservices {
  Dbservices._();
  static final Dbservices _instance = Dbservices._();
  static Dbservices get instance => _instance;
  static late Database myDb;
  initializeDb()async{
    myDb=await openDatabase('quaran.db',version: 1,onCreate: (db, version) async{
      await db.execute("CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date Timestamp)");
    },);
  }
  retrieveAllData()async{
    List<Notesmodel> notesList=[];
    var notesRowData=await myDb.rawQuery("SELECT * FROM Notes");
    for(var note in notesRowData){
      notesList.add(Notesmodel.fromJson(note));
    }
    return notesList;
  }
  insertData(String title,String content)async{
    await myDb.rawInsert("INSERT INTO Notes(title,content) VALUES('$title','$content')");
  }
  deleteNote(int id)async{
    await myDb.rawDelete("Delete FROM Notes WHERE id=$id");
  }
}