import 'package:flutter/material.dart';
import 'package:todo_app/core/page_state.dart';
import 'package:todo_app/presentation/pages/todo_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/providers/todo_provider.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  FilterMode modeLoad;

  void _onItemTapped(int index) async {
    switch (index) {
      case 0:
        modeLoad = FilterMode.ALL;
        break;
      case 1:
        modeLoad = FilterMode.COMPLETE;
        break;
      case 2:
        modeLoad = FilterMode.INCOMPLETE;
        break;
    }
    context.read<TodoProvider>().filterTodo(modeLoad);
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    TodoScreen(filterMode: FilterMode.ALL),
    TodoScreen(filterMode: FilterMode.COMPLETE),
    TodoScreen(filterMode: FilterMode.INCOMPLETE),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            label: 'All',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check_rounded),
            label: 'Complete',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add),
            label: 'InComplete',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
