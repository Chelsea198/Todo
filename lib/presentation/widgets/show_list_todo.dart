import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/page_state.dart';
import 'package:todo_app/presentation/providers/todo_provider.dart';

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