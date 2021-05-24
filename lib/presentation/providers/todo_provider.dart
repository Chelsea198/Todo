import 'package:flutter/material.dart';
import 'package:todo_app/core/page_state.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/domain/entities/todo.dart';
import 'package:todo_app/domain/usecases/todo_usecases.dart';

class TodoProvider extends ChangeNotifier {
  PageState pageState;
  FilterMode mode;
  List<Todo> listTodo = [];
  List<Todo> filterListTodo = [];
  var usecase = TodoUsecase(TodoRepository());

  getListTodo() async {
    pageState = PageState.LOADING;
    try {
      listTodo = await usecase.getListTodo();
      filterListTodo = listTodo;
      pageState = PageState.LOADED;
      notifyListeners();
    } catch (e) {
      pageState = PageState.ERROR;
      print(e);
    }
  }

  updateTodo(int index, Todo updateTodo) async {
    listTodo[listTodo.indexWhere((e) => e.id == updateTodo.id)] = updateTodo;
    try {
      usecase.updateTodo(updateTodo);
      filterTodo(mode);
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  filterTodo(FilterMode mode) /*async*/ {
    this.mode = mode;
    // pageState = PageState.LOADING;
    // notifyListeners();
    // await Future.delayed(Duration(seconds: 5));
    switch (mode) {
      case FilterMode.ALL:
        filterListTodo = listTodo;
        break;
      case FilterMode.COMPLETE:
        filterListTodo = listTodo.where((e) => e.isComplete).toList();
        break;
      case FilterMode.INCOMPLETE:
        filterListTodo = listTodo.where((e) => !e.isComplete).toList();
        break;
    }
    // pageState = PageState.LOADED;
    notifyListeners();
  }
}
