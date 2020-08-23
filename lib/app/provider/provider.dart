import 'package:todo_list/app/database/db_helper.dart';
import 'package:todo_list/app/model/todos.dart';

class Provider{
  Provider();
  var dbHelper = DBHelper();
  
  Future<Todos>createTodo(Todos todos)async => dbHelper.createTodo(todos);
  Future<List<Todos>>getTodoList() async=> dbHelper.getTodoList();
  Future<Todos>getTodoDetailsById(int id)async=> dbHelper.getTodoDetailsById(id);
  Future<bool>updateTodoByModel(Todos todo) async=> dbHelper.updateTodoByModel(todo);
  Future<int>deleteTodoById(int id)async => dbHelper.deleteTodoById(id);
}