import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/page_state.dart';
import 'package:todo_app/presentation/providers/todo_provider.dart';

class TodoScreen extends StatefulWidget {
  final FilterMode filterMode;

  const TodoScreen({@required this.filterMode, Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().getListTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  child: Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                displayText(widget.filterMode)
              ],
            ),
          ),
          ListTodo(
            mode: widget.filterMode,
          ),
        ],
      ),
    );
  }
}

Text displayText(FilterMode filterMode){
  switch(filterMode){
    case FilterMode.ALL:
      return Text('All Task',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),);
    case FilterMode.COMPLETE:
      return Text('Complete Task',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),);
    case FilterMode.INCOMPLETE:
      return Text('InComplete Task',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),);
  }
  return Text('');
}
class ListTodo extends StatelessWidget {
  const ListTodo({
    Key key,
    @required this.mode,
  }) : super(key: key);

  final FilterMode mode;

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, bloc, _) {
        if (bloc.pageState == PageState.LOADING) {
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
        } else if (bloc.pageState == PageState.LOADED) {
          return Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 5),
                itemCount: bloc.filterListTodo.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white,),
                itemBuilder: (context, i) {

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(1,1)
                          )
                        ]
                    ),
                    child: Row(
                      key: ValueKey('${bloc.filterListTodo[i].id}'),
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            side: BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            value: bloc.filterListTodo[i].isComplete,
                            onChanged: (value) {
                              bloc.updateTodo(
                                  i,
                                  bloc.filterListTodo[i]
                                      .copyWith(isComplete: value));
                            },
                          ),
                        ),
                        Text(bloc.filterListTodo[i].title),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else
          return const SizedBox();
      },
    );
  }
}