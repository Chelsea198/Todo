import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/domain/entities/todo.dart';

class MockitoFetchData extends Mock implements http.Client {}

void main() {
  group('Restful API', () {
    test('returns a List Todo if there is no error', () async {
      http.Client mockito = MockitoFetchData();

      when(mockito.get(
              Uri.parse('https://60a8d0d220a6410017306462.mockapi.io/todos')))
          .thenAnswer((_) async => http.Response(
              '{"id": 1, "title": 1, "description": "mock",isComplete:$isTrue}',
              200));

      expect(await TodoRepository().getListTodo(), isA<List<Todo>>());
    });
    test('returns a List Todo if there is no error', () async {
      http.Client mockito = MockitoFetchData();

      when(mockito.put(
              Uri.parse('https://60a8d0d220a6410017306462.mockapi.io/todos')))
          .thenAnswer((_) async => http.Response(
              '{"id": 1, "title": 1, "description": "mock",isComplete:$isTrue}',
              200));

      expect(
          await TodoRepository().updateTodo(Todo(
              id: '1',
              title: 'Task 1',
              description: 'Task 1',
              isComplete: true)),
          isA<List<Todo>>());
    });
  });


}
