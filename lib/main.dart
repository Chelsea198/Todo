import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/presentation/pages/nav_screen.dart';
import 'package:todo_app/presentation/pages/todo_screen.dart';
import 'package:todo_app/presentation/providers/todo_provider.dart';

void main() => runApp(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => TodoProvider(),
          child: NavScreen(),
        ),
      ),
    );


