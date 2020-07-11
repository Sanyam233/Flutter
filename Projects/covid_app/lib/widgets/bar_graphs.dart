import 'package:covid_app/assists/size_config.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

//https://dribbble.com/shots/2144199-Filter-iOS
class BarGraphs extends StatelessWidget {
  BarGraphs(this.sortedCountryData, this.length, this.optionIndex);

  final List sortedCountryData;
  final int length;
  final int optionIndex;
  final double _heightMultiplier = SizeConfig.heightMultiplier;
  final double _widthMultiplier = SizeConfig.widthMultiplier;

  List<BarData> countryBarList = [];
  var series;

  @override
  Widget build(BuildContext context) {
    if (sortedCountryData != null) {
      String label = optionIndex == 0 ? "deaths" : "confirmed";
      countryBarList = [];

      for (int i = 0; i < 10; i++) {
        countryBarList.add(BarData(sortedCountryData[i]["code"],
            sortedCountryData[i]["latest_data"][label], Color(0xFFEF2D56)));
      }

      series = [
        charts.Series(
          id: 'CovidStats',
          domainFn: (BarData bardata, _) => bardata.countryName,
          measureFn: (BarData bardata, _) => bardata.countryCases,
          colorFn: (BarData bardata, _) =>
              charts.ColorUtil.fromDartColor(bardata.color),
          data: countryBarList,
        ),
      ];
    }

    return Container(
      height: 27.90 * _heightMultiplier,
      width: 96.62 * _widthMultiplier,
      margin: EdgeInsets.symmetric(horizontal: 1.21 * _widthMultiplier),
      child: (sortedCountryData == null)
          ? Center(child: CircularProgressIndicator())
          : charts.BarChart(
              series,
              animate: true,
            ),
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
    );
  }
}

class BarData {
  final String countryName;
  final int countryCases;
  final Color color;

  BarData(this.countryName, this.countryCases, this.color);
}
