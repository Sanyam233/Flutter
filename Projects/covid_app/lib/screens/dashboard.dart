import 'package:covid_app/assists/size_config.dart';
import 'package:covid_app/providers/appbar.dart';
import 'package:covid_app/providers/covid_data.dart';
import 'package:covid_app/screens/Countries_insights.dart';
import 'package:covid_app/widgets/bar_graphs.dart';
import 'package:covid_app/widgets/country_insight_widget.dart';
import 'package:covid_app/widgets/summary_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedindex = 0;
  bool _fetchGlobalData = true;
  var covidGlobalData;
  List _sortedCountryData;
  List _selectedFilter;
  List _finalFilter = ["latest_data", "confirmed", 1];
  List _sortedByDeceased;
  int colorChange = 0;
  final double _heightMultiplier = SizeConfig.heightMultiplier;
  final double _widthMultiplier = SizeConfig.widthMultiplier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_fetchGlobalData == true) {
      Provider.of<CovidData>(context, listen: true).sortedData();
      Provider.of<CovidData>(context, listen: true).sortedbyDeceased();
      _fetchGlobalData = false;
    }
  }

  Future _filterdialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            height: 13.39 * _heightMultiplier,
            width: 72.46 * _widthMultiplier,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 2.42 * _widthMultiplier,
                  right: 2.42 * _widthMultiplier,
                  top: 1.12 * _heightMultiplier,
                  bottom: 0.22 * _heightMultiplier),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Top 10 Countries",
                      style: Theme.of(context).textTheme.headline2),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectedFilter = ["latest_data", "deaths", 0];
                            setState(() {
                              colorChange = 1;
                              _finalFilter = _selectedFilter;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 3.91 * _heightMultiplier,
                            width: 20.53 * _widthMultiplier,
                            decoration: BoxDecoration(
                              color: colorChange == 1
                                  ? Theme.of(context).accentColor
                                  : Colors.white,
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).accentColor),
                            ),
                            child: Text(
                              "Deaths",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize:
                                      1.79 * _heightMultiplier,
                                  color: colorChange == 1
                                      ? Colors.white
                                      : Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectedFilter = ["latest_data", "confirmed", 1];

                            setState(() {
                              colorChange = 2;
                              _finalFilter = _selectedFilter;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 3.91 * _heightMultiplier,
                            width: 20.53 * _widthMultiplier,
                            decoration: BoxDecoration(
                              color: colorChange == 2
                                  ? Theme.of(context).accentColor
                                  : Colors.white,
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).accentColor),
                            ),
                            child: Text(
                              "Cases",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 1.79 * _heightMultiplier,
                                  color: colorChange == 2
                                      ? Colors.white
                                      : Theme.of(context).accentColor),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_finalFilter[2] == 0) {
      _sortedByDeceased = Provider.of<CovidData>(context).sortByDeceased;
    } else {
      _sortedCountryData = Provider.of<CovidData>(context).sortedCountryData;
    }

    return Scaffold(
      appBar: Appbar.appBar(context),
      body: _selectedindex == 1
          ? CountriesInsights()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 22.32 * _heightMultiplier,
                    width: double.infinity,
                    child: SummaryTiles(),
                  ),
                  GestureDetector(
                    onTap: () => _filterdialogue(context),
                    child: Container(
                      margin: EdgeInsets.only(left: 1.21 * _widthMultiplier),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      width: 21.74 * _widthMultiplier,
                      height: 3.35 * _heightMultiplier,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Filters",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SvgPicture.asset("assets/images/slider.svg",
                              height: 1.45 * _heightMultiplier,
                              color: Theme.of(context).accentColor,
                              semanticsLabel: "slider"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0.56 * _heightMultiplier),
                  BarGraphs(
                      _finalFilter[2] == 0
                          ? _sortedByDeceased
                          : _sortedCountryData,
                      10,
                      _finalFilter[2]),
                  SizedBox(height: 1.67 * _heightMultiplier),
                  _sortedCountryData == null
                      ? Container()
                      : Container(
                          width: double.infinity,
                          height: 44.64 * _heightMultiplier,
                          child: CountryInsightsWidget(
                              _finalFilter[2] == 0
                                  ? _sortedByDeceased
                                  : _sortedCountryData,
                              10,
                              ""),
                        ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedindex,
        onTap: (index) {
          setState(
            () {
              _selectedindex = index;
            },
          );
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Dashboard"),
            icon: SvgPicture.asset("assets/images/dashboard.svg",
                height: 4.24 * _heightMultiplier,
                width: 7.25 * _widthMultiplier,
                color: _selectedindex == 0
                    ? Theme.of(context).accentColor
                    : Colors.grey,
                semanticsLabel: "dashboard"),
          ),
          BottomNavigationBarItem(
            title: Text("Countries"),
            icon: SvgPicture.asset("assets/images/world.svg",
                height: 3.91 * _heightMultiplier,
                width: 7.25 * _widthMultiplier,
                color: _selectedindex == 1
                    ? Theme.of(context).accentColor
                    : Colors.grey,
                semanticsLabel: "list"),
          )
        ],
        unselectedItemColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Theme.of(context).accentColor,
        iconSize: 3.57 * _heightMultiplier,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
    );
  }
}
