import 'package:dio/dio.dart';
import 'package:todo_app/data/configs/base_url.dart';
import 'package:todo_app/domain/entities/todo.dart';
import 'package:todo_app/domain/repositories/i_todo_repository.dart';

class TodoRepository implements ITodoRepository {
  final dio = Dio();

  @override
  Future<List<Todo>> getListTodo() async {
    try {
      Response response = await dio.get(url_Api);
      return List<Todo>.from(response.data.map((json) => Todo.fromJson(json)));
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future updateTodo(Todo todo) async {
    try {
      await dio.put(
        '$url_Api' + '/${todo.id}',
        data: todo.toJson(),
      );
    } catch (e) {
      throw (e);
    }
  }
}
