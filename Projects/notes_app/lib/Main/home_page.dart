import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:provider/provider.dart';

import '../Main/bottom_navigation.dart';
import '../Main/date_tile_display.dart';
import '../Models/date_time.dart';
import '../Page_One/page_One.dart';
import '../Providers/taskList.dart';
import '../page_two/page_two.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexVal = 2;
  var _selectedMonthValue = DateFormat.MMMM().format(DateTime.now());
  var _selectedYearValue = DateFormat.y().format(DateTime.now());
  var dateTime;
  var _initState = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initState) {
      Provider.of<TaskList>(context, listen: false).fetchData();
    }

    _initState = false;
  }

  @override
  Widget build(BuildContext context) {
    var _months = Provider.of<DateTimeProto>(context).months;
    var _years = Provider.of<DateTimeProto>(context).years;
    var dateTimeList = Provider.of<DateTimeProto>(context).dateTimeList;

    AppBar appBar = AppBar(
      backgroundColor: AppTheme.appBackgroundColor,
      elevation: 0.0,
      centerTitle: false,
      title: Row(
        children: <Widget>[
          Text(
            "T",
            style: Theme.of(context).textTheme.headline3,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Icon(
              Icons.list,
              color: AppTheme.primaryColor,
              size: 3.12 * SizeConfig.textMultiplier,
            ),
          ),
          Text(
            "Do",
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 0.56 * SizeConfig.heightMultiplier),
          child: DropdownButton(
            underline: Container(color: AppTheme.appBackgroundColor),
            style: TextStyle(color: AppTheme.textColor),
            icon: Icon(Icons.expand_more),
            value: _selectedMonthValue,
            items: _months.map((month) {
              return DropdownMenuItem(
                child: Text(
                  month,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                value: month,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedMonthValue = value;
              });
              Provider.of<TaskList>(context, listen: false)
                  .refreshTaskListMethod();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.56 * SizeConfig.heightMultiplier),
          child: DropdownButton(
            icon: Icon(Icons.expand_more),
            underline: Container(
              color: Colors.white,
            ),
            value: _selectedYearValue,
            items: _years.map((year) {
              return DropdownMenuItem(
                child: Text(
                  year,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                value: year,
              );
            }).toList(),
            onChanged: (value) {
              setState(
                () {
                  _selectedYearValue = value;
                },
              );

              Provider.of<TaskList>(context, listen: false)
                  .refreshTaskListMethod();
            },
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppTheme.appBackgroundColor,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if((SizeConfig.orientationType == Orientation.portrait) || (SizeConfig.heightMultiplier >= 9.0))
            Container(
              width: double.infinity,
              height: 15.07 * SizeConfig.heightMultiplier, 
              child: DateTileDisplay(dateTime != null ? dateTime : dateTimeList,
                  _selectedMonthValue, _selectedYearValue),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.appBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              height: 67 * SizeConfig.heightMultiplier,
              width: double.infinity,
              child: PageView(
                controller: PageController(initialPage: 1),
                children: [PageOne(), PageTwo()],
                onPageChanged: (val) {
                  if (val == 1) {
                    val = 2;
                  }
                  setState(
                    () {
                      _indexVal = val;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(_indexVal),
    );
  }
}
