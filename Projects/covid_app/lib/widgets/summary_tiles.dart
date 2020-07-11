import 'package:covid_app/assists/size_config.dart';
import 'package:covid_app/providers/covid_data.dart';
import 'package:covid_app/providers/icons_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryTiles extends StatefulWidget {
  @override
  _SummaryTilesState createState() => _SummaryTilesState();
}

class _SummaryTilesState extends State<SummaryTiles> {
  bool _fetchGlobalData = true;
  var covidGlobalData;
  List _globalStatsKeys;
  final double _heightMultiplier = SizeConfig.heightMultiplier;
  final double _widthMultiplier = SizeConfig.widthMultiplier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_fetchGlobalData == true) {
      covidGlobalData =
          Provider.of<CovidData>(context, listen: true).fetchGlobalData();
      _fetchGlobalData = false;
    }
  }

  String capsTitle(String tileTitle) {
    return "${tileTitle[0].toUpperCase()}${tileTitle.substring(1)}";
  }

  @override
  Widget build(BuildContext context) {
    var globalStats =
        Provider.of<CovidData>(context, listen: false).globalStats;
    var iconsData = Provider.of<IconsData>(context, listen: false).icons;

    if (globalStats != null) {
      _globalStatsKeys = globalStats.keys.toList();
    }

    return globalStats == null
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              String _tileTitle =
                  _globalStatsKeys[(_globalStatsKeys.length - 5) - index];

              return Container(
                width: 36.23 * _widthMultiplier,
                margin: EdgeInsets.symmetric(horizontal: 1.93 * _widthMultiplier, vertical: 2.42 * _widthMultiplier),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3)
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconsData[index],
                    Text(
                      capsTitle(_tileTitle),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      globalStats[_tileTitle].toString(),
                      style: Theme.of(context).textTheme.headline2,
                    )
                  ],
                ),
              );
            },
          );
  }
}
