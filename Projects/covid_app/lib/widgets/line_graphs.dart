import 'package:covid_app/assists/size_config.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class LineGraph extends StatelessWidget {
  LineGraph(this.lineChartData);

  List lineChartData;
  List<charts.Series<LineData, DateTime>> series;
  final double _heightMultiplier = SizeConfig.heightMultiplier;
  final double _widthMultiplier = SizeConfig.widthMultiplier;

  List<LineData> countryLineData = [];

  @override
  Widget build(BuildContext context) {
    if (lineChartData != null) {
      for (int i = 0; i < lineChartData.length; i++) {
        countryLineData.add(
          LineData(
            DateTime.parse(lineChartData[i]["updated_at"]),
            lineChartData[i]["new_confirmed"],
            Color(0xFFEF2D56),
          ),
        );
      }
      series = [
        charts.Series(
          id: 'CovidStats',
          domainFn: (LineData lineData, _) => lineData.time,
          measureFn: (LineData lineData, _) => lineData.countryCases,
          colorFn: (LineData lineData, _) =>
              charts.ColorUtil.fromDartColor(lineData.color),
          data: countryLineData,
        ),
      ];
    }

    return Container(
      height: 27.90 * _heightMultiplier,
      width: 96.62 * _widthMultiplier,
      margin: EdgeInsets.symmetric(horizontal: 1.21 * _widthMultiplier),
      child: lineChartData == null
          ? Center(child: CircularProgressIndicator())
          : charts.TimeSeriesChart(
              series,
              animate: true,
              defaultRenderer: charts.LineRendererConfig(includeArea: true),
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

class LineData {
  final DateTime time;
  final int countryCases;
  final Color color;

  LineData(this.time, this.countryCases, this.color);
}
