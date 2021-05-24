import 'package:todo_app/domain/entities/todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getListTodo();
  Future updateTodo(Todo todo);
}