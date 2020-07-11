import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Models/task.dart';
import 'package:notes_app/Providers/taskList.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:provider/provider.dart';

class ToDoPopUp extends StatefulWidget {
  @override
  _ToDoPopUpState createState() => _ToDoPopUpState();
}

class _ToDoPopUpState extends State<ToDoPopUp> {
  double spacing = 0.0;
  final _formKey = GlobalKey<FormState>();
  final _notesFocus = FocusNode();

  static double _heightMultiplier = SizeConfig.heightMultiplier;
  static double _widthMultiplier = SizeConfig.widthMultiplier;

  Tasks newTask = Tasks(
    retrivalId: null,
    title: "",
    notes: "",
    completed: false,
    important: false,
    dealLine: null,
    username: null,
  );

  Future<void> addTasks() async {
    var _validate = _formKey.currentState.validate();

    if (!_validate) {
      return;
    } else {
      _formKey.currentState.save();
    }

    Provider.of<TaskList>(context, listen: false)
        .addTask(newTask, newTask.retrivalId)
        .then((_) {
      Navigator.of(context).pop();
    }).catchError(
      (error) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(
                  left: 13.2 * _widthMultiplier, top: 1.17 * _heightMultiplier),
              title: Text(
                "Error Occured",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              backgroundColor: AppTheme.primaryColor,
              content: Container(
                height: 4.46 * _heightMultiplier,
                width: 36.23 * _widthMultiplier,
                child: Text(
                  "The task could'nt be added",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontSize: 2.23 * _heightMultiplier),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child:
                      Text("Okay", style: Theme.of(context).textTheme.button),
                ),
              ],
            );
          },
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      backgroundColor: Theme.of(context).primaryColor,
      content: Container(
        height: SizeConfig.heightAdjustment(_heightMultiplier),
        width: 120.77 * _widthMultiplier,
        decoration: BoxDecoration(color: AppTheme.primaryColor),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    bottom: 0.11 * _heightMultiplier,
                    left: 0.48 * _widthMultiplier),
                child: TextFormField(
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_notesFocus),
                  textAlign: TextAlign.start,
                  onTap: () {
                    setState(() {
                      spacing = 1.89 * _heightMultiplier;
                    });
                  },
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2,
                  cursorColor: AppTheme.accentColor,
                  decoration: InputDecoration(
                      errorStyle:
                          TextStyle(color: AppTheme.errorColor, fontSize: 0.0),
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: spacing),
                        child: Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.white24,
                        ),
                      ),
                      labelText: "New To Do",
                      labelStyle: Theme.of(context).textTheme.headline4),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter a task title";
                    }
                    return null;
                  },
                  onSaved: (value) => newTask.title = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 12 * _widthMultiplier, top: 0.0 * _heightMultiplier),
                child: TextFormField(
                  focusNode: _notesFocus,
                  onSaved: (value) => newTask.notes = value,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2,
                  cursorColor: AppTheme.accentColor,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Notes",
                      labelStyle: Theme.of(context).textTheme.headline4),
                  validator: (value) {
                    if (value.isEmpty) {
                      value = "";
                      return null;
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: 1.93 * _widthMultiplier, top: 0.33 * _heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                          newTask.important == true
                              ? Icons.star
                              : Icons.star_border,
                          size: 3.35 * _heightMultiplier,
                          color: AppTheme.accentColor),
                      onPressed: () {
                        setState(
                          () {
                            newTask.important = !newTask.important;
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today,
                          size: 2.79 * _heightMultiplier,
                          color: AppTheme.accentColor),
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime(
                              int.parse(DateFormat.y().format(DateTime.now())),
                              int.parse(
                                DateFormat.M().format(DateTime.now()),
                              ),
                              int.parse(
                                DateFormat.d().format(
                                  DateTime.now(),
                                ),
                              ),
                            ),
                            firstDate:
                                DateTime.now().subtract(Duration(hours: 24)),
                            lastDate: DateTime(2050, 1, 1),
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
                            }).then(
                          (datePicked) {
                            if (datePicked == null) {
                              Navigator.of(context).pop();
                            }
                            newTask.retrivalId = datePicked;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.56 * _heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      color: AppTheme.accentColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: AppTheme.primaryColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 1.93 * _widthMultiplier, left: 8),
                      child: FlatButton(
                        color: AppTheme.accentColor,
                        onPressed: () {
                          addTasks();
                        },
                        child: Text(
                          "Save",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: AppTheme.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
