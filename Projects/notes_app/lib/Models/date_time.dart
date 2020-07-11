import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeProto extends ChangeNotifier {
  List<dynamic> _dateTimeList = [];

  List _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List _years = [
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030"
  ];

  Future<void> dateGenerator(
      String month, List _dateTimeList, String year) async {
    var dateUtility = DateUtil();
    int numberOfDays = 0;

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

    if (month == DateFormat.LLLL().format(DateTime.now()) &&
        year == DateFormat.y().format(DateTime.now())) {
      numberOfDays = dateUtility.daysInMonth(monthNum[month], int.parse(year));
          // int.parse(DateFormat.d()
          //     .format(DateTime.now().subtract(Duration(days: 1))));
    } else {
      numberOfDays = dateUtility.daysInMonth(monthNum[month], int.parse(year));
    }

    for (int i = 0; i < numberOfDays; i++) {
      if (month == DateFormat.LLLL().format(DateTime.now()) &&
          year == DateFormat.y().format(DateTime.now())) {
        DateTime date = DateTime.now().add(Duration(days: i));

        _dateTimeList.add({
          "Day": DateFormat.E().format(date).toString(),
          "date": date.day.toString(),
          "Month": month,
          "year" : year
        });
      } else {
        int dateNum = 1 + i;

        DateTime date = DateTime(int.parse(year), monthNum[month], dateNum);

        _dateTimeList.add({
          "Day": DateFormat.E().format(date).toString(),
          "date": dateNum.toString(),
          "Month": month,
          "year" : year,
        });
      }
    }
    //print(_dateTimeList);
  }

  List<dynamic> get dateTimeList => [..._dateTimeList];
  List<dynamic> get months => [..._months];
  List<dynamic> get years => [..._years];

}
