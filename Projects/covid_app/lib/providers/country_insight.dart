import 'package:flutter/material.dart';

class CountryInsight {

  static String _titleString(
      List countryWiseStats, String labelKey, int index, int labelIndex) {
    String title = countryWiseStats[index][labelKey].keys.toList()[labelIndex];
    return "${title[0].toUpperCase()}${title.substring(1)}";
  }

  static String _labelData(
      List countryWiseStats, String dataKey, String dataSecond_key, int index) {
    return countryWiseStats[index][dataKey][dataSecond_key].toString();
  }

  static Widget dataColumns(BuildContext context,List countryWiseStats, String labelKey, int index,
      int labelIndex, String dataKey, String dataSecond_key) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text(
          labelIndex == 0 ? "New Deaths" : "New Cases",
        style: Theme.of(context).textTheme.headline3),
        Text(
          _labelData(countryWiseStats, dataKey, dataSecond_key, index),
        style:Theme.of(context).textTheme.subtitle1 ),
      ],
    );
  }
}
