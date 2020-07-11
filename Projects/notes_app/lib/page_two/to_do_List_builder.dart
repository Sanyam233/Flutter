import 'package:flutter/material.dart';

import 'package:notes_app/Models/task.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:notes_app/page_two/task_list_tile.dart';

class TodoListBuilder extends StatefulWidget {
  TodoListBuilder({
    @required this.taskList,
  });

  final List<Tasks> taskList;

  @override
  _TodoListBuilderState createState() => _TodoListBuilderState();
}

class _TodoListBuilderState extends State<TodoListBuilder> {
  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(
        () {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final Tasks item = widget.taskList.removeAt(oldIndex);
          widget.taskList.insert(newIndex, item);
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 3.35 * SizeConfig.heightMultiplier, left: 7.25 * SizeConfig.widthMultiplier),
          child: Text(
            "Tasks",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
          child: Theme(
            data: ThemeData(
              canvasColor: Colors.transparent,
              accentColor: AppTheme.accentColor,
            ),
            child: ReorderableListView(
              children: widget.taskList.map(
                (task) {
                  return TaskListTile(
                      key: Key('${task.taskId}'),
                      taskId: task.taskId,
                      retrivalId: task.retrivalId,
                      title: task.title,
                      notes: task.notes,
                      complete: task.completed);
                },
              ).toList(),
              onReorder: _onReorder,
            ),
          ),
        ),
      ],
    );
  }
}
