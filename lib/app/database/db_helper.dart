

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:todo_list/app/model/todos.dart';
class DBHelper{
  
  DBHelper();

  static Database _db;
  static const String TODO = "TODO";
  
  //Columns
  static const String ID = "id";
  static const String PRIORITY = "priority";
  static const String TITLE = "title";
  static const String DESCRIPTION = "description";
  static const String UPDATEDATE = "updDate";

  //Database Name
  static const String DB_NAME = "todo.db";

  Future<Database>get db async{
    if(_db !=null)return _db;
    _db = await _initDb();
    return _db;
  }

  _initDb()async{
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path,DB_NAME);
    var db = await openDatabase(path,version: 2,onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version)async{
    String todoTable = """
    CREATE TABLE $TODO(
      $ID INTEGER PRIMARY KEY,
      $PRIORITY TEXT,
      $TITLE TEXT,
      $DESCRIPTION TEXT,
      $UPDATEDATE TEXT
    )
    """;
   await db.execute(todoTable);
  }

  Future<Todos> createTodo(Todos todos)async{
    var dbClient = await db;
    todos.id = await dbClient.insert(TODO, todos.toMap());
    print(todos.id);
    return todos;
  }

  Future<List<Todos>>getTodoList()async{
      var dbClient = await db;
         List<Map> map =
       await dbClient.query(TODO, columns:[
          ID,PRIORITY,TITLE,DESCRIPTION, UPDATEDATE
       ],orderBy: "$ID DESC");

      List<Todos> todos = [];
      if(map.length > 0){
        for(int i = 0; i < map.length; i++){
          todos.add(Todos.fromMap(map[i]));
        }
      }
    return todos;
  }

  Future<Todos>getTodoDetailsById(int id)async{
       var dbClient = await db;
       var result = await dbClient.rawQuery("SELECT * FROM $TODO WHERE $ID = '$id'");
       return (result.length > 0)? Todos.fromMap(result.first):null;
  }

  Future<bool>updateTodoByModel(Todos todo)async{
     var dbClient = await db;
     var result = await dbClient.update(TODO,todo.toMap(), where:"$ID = ?",whereArgs: [todo.id]);
    return (result > 0);
  }

  Future<int>deleteTodoById(int id)async{
     var dbClient = await db;
     return await dbClient.delete(TODO, where: "$ID = ?", whereArgs: [id]);
  }
 
}