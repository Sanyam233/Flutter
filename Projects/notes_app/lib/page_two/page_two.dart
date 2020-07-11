import 'package:flutter/material.dart';
import 'package:notes_app/Providers/taskList.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:notes_app/page_two/to_do_List_builder.dart';
import 'package:provider/provider.dart';

class PageTwo extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    //setting up listener for providers
    final taskListProvider = Provider.of<TaskList>(context);
    final taskList = taskListProvider.filterTaskList;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: TodoListBuilder(taskList: taskList),
    );
  }
}

