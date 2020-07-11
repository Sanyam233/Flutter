
import 'package:covid_app/assists/size_config.dart';
import 'package:covid_app/providers/country_insight.dart';
import 'package:covid_app/screens/country_stats.dart';
import 'package:flutter/material.dart';

class CountryInsightTile extends StatelessWidget {
  CountryInsightTile(this.countryWiseStats, this.index,
  );

  final List countryWiseStats;
  final int index;

  final double _heightMultiplier = SizeConfig.heightMultiplier;
  final double _widthMultiplier = SizeConfig.widthMultiplier;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                CountryStats(countryWiseStats[index])));
      },
      child: Container(
        height: 10.04 * _heightMultiplier,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 36.23 * _widthMultiplier,
              margin: EdgeInsets.only(left: 3.62 * _widthMultiplier),
              child: Text(
                countryWiseStats[index]["name"],
                style: Theme.of(context).textTheme.headline2,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Container(
              width: 55.56 * _widthMultiplier,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CountryInsight.dataColumns(context,countryWiseStats, "today",
                      index, 0, "today", "deaths"),
                  CountryInsight.dataColumns(context, countryWiseStats, "today",
                      index, 1, "today", "confirmed")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
