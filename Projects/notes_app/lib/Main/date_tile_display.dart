import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Models/date_time.dart';
import 'package:notes_app/Providers/taskList.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:provider/provider.dart';

class DateTileDisplay extends StatefulWidget {
  final List<dynamic> dateTimeList;
  var _selectedMonthValue;
  var _selectedYearValue;

  DateTileDisplay(
      this.dateTimeList, this._selectedMonthValue, this._selectedYearValue);

  @override
  _DateTileDisplayState createState() => _DateTileDisplayState();
}

class _DateTileDisplayState extends State<DateTileDisplay> {
  int taskCounter = 0;
  int colorCounter = 0;
  int colorIndex;

  static double _heightMultiplier = SizeConfig.heightMultiplier;
  static double _widthMultiplier = SizeConfig.widthMultiplier;

  Map<String, int> monthNum = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12,
  };

  @override
  Widget build(BuildContext context) {
    if (taskCounter == 0) {
      DateTime dateTimeVar = DateTime(
          int.parse(DateFormat.y().format(DateTime.now())),
          int.parse(DateFormat.M().format(DateTime.now())),
          int.parse(DateFormat.d().format(DateTime.now())));

      Provider.of<TaskList>(context, listen: false)
          .initalTaskListMethod(dateTimeVar);

      taskCounter = 1;
    }

    final copyTheme = Theme.of(context).textTheme.subtitle1.copyWith;

    if (widget._selectedMonthValue != null &&
        widget._selectedYearValue != null) {
      Provider.of<DateTimeProto>(context).dateGenerator(
          widget._selectedMonthValue,
          widget.dateTimeList,
          widget._selectedYearValue);

      if (colorCounter == 0) {
        colorIndex = 0;
        colorCounter = 1;
      } else {
        colorIndex = -1;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.appBackgroundColor,
      ),
      height: 15.07 * SizeConfig.heightMultiplier,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(
            left: 1.21 * _widthMultiplier, right: 1.21 * _widthMultiplier),
        scrollDirection: Axis.horizontal,
        itemCount: widget.dateTimeList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(
                () {
                  colorIndex = index;
                  widget._selectedMonthValue = null;
                  widget._selectedYearValue = null;
                },
              );

              DateTime dateTimeVar = DateTime(
                  int.parse(widget.dateTimeList[index]["year"]),
                  monthNum[widget.dateTimeList[index]["Month"]],
                  int.parse(widget.dateTimeList[index]["date"]));

              Provider.of<TaskList>(context).filterTaskListMethod(dateTimeVar);
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: 0.89 * _heightMultiplier,
                  horizontal: 1.45 * _widthMultiplier),
              height: 8.93 * _heightMultiplier,
              width: 19.32 * _widthMultiplier,
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 1.45 * _heightMultiplier),
                    child: Text(
                      widget.dateTimeList[index]["Day"],
                      style: index == colorIndex
                          ? copyTheme(color: AppTheme.primaryColor)
                          : copyTheme(color: AppTheme.appBackgroundColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.89 * _heightMultiplier,
                    ),
                    child: Text(
                      widget.dateTimeList[index]["date"],
                      style: (colorIndex == index)
                          ? copyTheme(color: AppTheme.primaryColor)
                          : copyTheme(color: AppTheme.appBackgroundColor),
                    ),
                  ),
                  Container(
                      color: (colorIndex == index)
                          ? AppTheme.primaryColor
                          : AppTheme.appBackgroundColor,
                      height: 0.22 * _heightMultiplier,
                      width: 6.03 * _widthMultiplier),
                  SizedBox(height: 0.56 * _heightMultiplier),
                  Container(
                      color: (colorIndex == index)
                          ? AppTheme.primaryColor
                          : AppTheme.appBackgroundColor,
                      height: 0.22 * _heightMultiplier,
                      width: 3.62 * _widthMultiplier),
                  SizedBox(height: 0.56 * _heightMultiplier),
                  Container(
                      color: (colorIndex == index)
                          ? AppTheme.primaryColor
                          : AppTheme.appBackgroundColor,
                      height: 0.22 * _heightMultiplier,
                      width: 2.41 * _widthMultiplier),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
