import 'package:todo_app/domain/entities/todo.dart';
import 'package:todo_app/domain/repositories/i_todo_repository.dart';

class TodoUsecase {
  final ITodoRepository repository;

  TodoUsecase(this.repository);

  Future<List<Todo>> getListTodo() async {
    return await repository.getListTodo();
  }

  Future updateTodo(Todo todo) async {
    await repository.updateTodo(todo);
  }
}