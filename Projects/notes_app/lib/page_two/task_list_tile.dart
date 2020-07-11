import 'package:flutter/material.dart';
import 'package:notes_app/Providers/taskList.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:provider/provider.dart';

class TaskListTile extends StatefulWidget {
  final String taskId;
  final DateTime retrivalId;
  final String title;
  final String notes;
  final Key key;
  bool complete;

  TaskListTile(
      {@required this.key,
      @required this.taskId,
      @required this.retrivalId,
      @required this.title,
      @required this.notes,
      @required this.complete});

  @override
  _TaskListTileState createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  static double _heightMultiplier = SizeConfig.heightMultiplier;
  static double _widthMultiplier = SizeConfig.widthMultiplier;

  TimeOfDay deadline;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      secondaryBackground: Container(
        padding: EdgeInsets.only(right: 4.83 * _widthMultiplier),
        child: Icon(Icons.delete, color: AppTheme.primaryColor),
        alignment: Alignment.centerRight,
        color: widget.complete ? AppTheme.disableColor : AppTheme.accentColor,
        height: 7.81 * _heightMultiplier,
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          Provider.of<TaskList>(context)
              .deleteTask(widget.taskId, widget.retrivalId);
        } else {
          Provider.of<TaskList>(context)
              .markComplete(widget.taskId, widget.retrivalId);
        }
      },
      key: ValueKey(widget.taskId),
      background: Container(
        padding: EdgeInsets.only(left: 4.83 * _widthMultiplier, top: 0.0),
        child: SizedBox(
          width: 2.42 * _widthMultiplier,
          height: 2.23 * _heightMultiplier,
          child: Icon(
            Icons.check,
            size: 2.68 * _heightMultiplier,
            color: AppTheme.primaryColor,
          ),
        ),
        alignment: Alignment.centerLeft,
        color: widget.complete ? AppTheme.disableColor : AppTheme.accentColor,
        height: 8.93 * _heightMultiplier,
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: SizeConfig.orientationType == Orientation.portrait ? 1.12 * _heightMultiplier :  5.12 * _heightMultiplier,
          top: 2.42 * _widthMultiplier,
          bottom: 2.42 * _widthMultiplier,

          right: SizeConfig.orientationType == Orientation.portrait ? 1.12 * _heightMultiplier :  5.12 * _heightMultiplier,


        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: widget.complete ? AppTheme.disableColor : AppTheme.accentColor,
        ),
        height: 7.81 * _heightMultiplier,
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 3.62 * _widthMultiplier, vertical: 2.0),
          leading: IconButton(
              icon: widget.complete
                  ? Icon(Icons.check_box, color: AppTheme.primaryColor)
                  : Icon(
                      Icons.check_box_outline_blank,
                      color: AppTheme.primaryColor,
                    ),
              onPressed: () {
                setState(() {
                  widget.complete = !widget.complete;
                });
              }),
          title: Text(
            widget.title,
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 2 * _heightMultiplier,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget.notes,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AppTheme.primaryColor,
                ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.alarm,
              size: 2.90 * _heightMultiplier,
              color: AppTheme.primaryColor,
            ),
            onPressed: widget.complete
                ? null
                : () async {
                    deadline = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor:
                                  AppTheme.accentColor, //Head background
                              accentColor: AppTheme.accentColor,
                              colorScheme: ColorScheme.light(
                                  primary: AppTheme.accentColor),
                              buttonTheme: ButtonThemeData(
                                  textTheme: ButtonTextTheme
                                      .primary), //selection color
                              dialogBackgroundColor: AppTheme
                                  .appBackgroundColor, //Background color
                            ),
                            child: child,
                          );
                        });

                    if (deadline != null) {
                      Provider.of<TaskList>(context).updateDeadline(
                          widget.taskId, widget.retrivalId, deadline);
                    }
                  },
          ),
        ),
      ),
    );
  }
}
