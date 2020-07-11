import 'package:covid_app/widgets/country_insight_tile.dart';
import 'package:flutter/material.dart';

class CountryInsightsWidget extends StatelessWidget {
  CountryInsightsWidget(this.countryWiseStats, this.length, this.filter);

  final List countryWiseStats;
  final int length;
  final String filter;

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(1, 3), // changes position of shadow
          ),
        ],),
      child: ListView.builder(
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          return filter == null || filter == ""
              ? CountryInsightTile(countryWiseStats, index)
              : countryWiseStats[index]["name"].contains(filter)
                  ? CountryInsightTile(countryWiseStats, index)
                  : Container();
        },
      ),
    );
  }
}
