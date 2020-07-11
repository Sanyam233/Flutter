import 'package:covid_app/assists/size_config.dart';
import 'package:covid_app/providers/covid_data.dart';
import 'package:covid_app/widgets/line_graphs.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CountryStats extends StatefulWidget {
  final countryStats;

  CountryStats(this.countryStats);

  @override
  _CountryStatsState createState() => _CountryStatsState();
}

class _CountryStatsState extends State<CountryStats> {
  List<dynamic> countryCovidTimeline;
  final double _heightMultiplier = SizeConfig.heightMultiplier;
  final double _widthMultiplier = SizeConfig.widthMultiplier;

  bool _fetchData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_fetchData == false) {
      Provider.of<CovidData>(context, listen: true)
          .countryTimeline(widget.countryStats["code"]);
      _fetchData = true;
    }
  }

  Widget stateRow(BuildContext context, String label, String value1,
      String value2, int option) {
    if (option == 0) {
      return Row(children: [
        Text(label, style: Theme.of(context).textTheme.headline6),
        SizedBox(width: 2.42 * _widthMultiplier),
        Text(
          widget.countryStats[value1].toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )
      ]);
    } else {
      return Row(children: [
        Text(label, style: Theme.of(context).textTheme.headline6),
        SizedBox(width: 2.42 * _widthMultiplier),
        Text(
          widget.countryStats[value1][value2].toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    countryCovidTimeline =
        Provider.of<CovidData>(context, listen: false).countryCovidTimeline;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 1.12 * _heightMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.countryStats["name"],
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontSize: 4.46 * _heightMultiplier),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.67 * _heightMultiplier, left: 0.48 * _widthMultiplier),
                      child: Text(
                        "+" +
                            widget.countryStats["today"]["confirmed"]
                                .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Theme.of(context).errorColor),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${DateFormat("Hms").format(DateTime.parse(widget.countryStats["updated_at"].toString()))}  ${DateFormat("MMMEd").format(DateTime.parse(widget.countryStats["updated_at"].toString().substring(0, 10)))}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          SizedBox(height: 2.79 * _heightMultiplier),
          LineGraph(countryCovidTimeline),
          SizedBox(height: 2.79 * _heightMultiplier),
          Container(
            height: 44.64 * _heightMultiplier,
            margin: EdgeInsets.only(left: 2.42 * _widthMultiplier, right: 3.62 * _widthMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.23 * _heightMultiplier),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Country Stats",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 1.67 * _heightMultiplier),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.83 * _widthMultiplier),
                          child: stateRow(context, "Total Population",
                              "population", null, 0),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.79 * _heightMultiplier),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(height: 1.67 * _heightMultiplier),
                        Padding(
                          padding: EdgeInsets.only(left:4.83 * _widthMultiplier),
                          child: Row(
                            children: [
                              stateRow(context, "Death", "today", "deaths", 1),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 43.4 * _widthMultiplier,
                                      alignment: Alignment.topLeft,
                                      child: stateRow(context, "Confirmed",
                                          "today", "confirmed", 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2.79 * _heightMultiplier),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Covid Stats",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(height: 1.67 * _heightMultiplier),
                          Padding(
                            padding:  EdgeInsets.only(left:4.83 * _widthMultiplier),
                            child: Row(
                              children: [
                                stateRow(context, "Death", "latest_data",
                                    "deaths", 1),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 43.4 * _widthMultiplier,
                                        alignment: Alignment.centerLeft,
                                        child: stateRow(context, "Confirmed",
                                            "latest_data", "confirmed", 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.67 * _heightMultiplier),
                          Padding(
                            padding: EdgeInsets.only(left: 4.83 * _widthMultiplier),
                            child: Row(
                              children: [
                                stateRow(context, "Recovered", "latest_data",
                                    "recovered", 1),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 43.4 * _widthMultiplier,
                                        alignment: Alignment.centerLeft,
                                        child: stateRow(context, "Critical",
                                            "latest_data", "critical", 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
