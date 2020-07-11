import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class CovidData extends ChangeNotifier {
  Map<String, dynamic> globalStats;
  List<dynamic> countryWiseStats;
  List<dynamic> sortedCountryData;
  List<dynamic> sortByDeceased;
  List<dynamic> countryCovidTimeline = [];

  Future<void> fetchGlobalData() async {
    final response = await http.get("https://corona-api.com/timeline");
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    globalStats = decoded["data"][0];

    notifyListeners();
  }

  Future<void> fetchCountryWiselData() async {
    final response = await http.get("https://corona-api.com/countries");
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    countryWiseStats = decoded["data"];
    // print(countryWiseStats);

    notifyListeners();
  }

  Future<void> sortedData() async {
    final response = await http.get("https://corona-api.com/countries");
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    sortedCountryData = decoded["data"];

    if (sortedCountryData != null) {
      for (int i = 0; i < sortedCountryData.length; i++) {
        int j = i + 1;

        while (j < sortedCountryData.length) {
          if (sortedCountryData[j]["latest_data"]["confirmed"] >
              sortedCountryData[i]["latest_data"]["confirmed"]) {
            var x = sortedCountryData[i];
            sortedCountryData[i] = sortedCountryData[j];
            sortedCountryData[j] = x;
          }
          j = j + 1;
        }
      }
    }

    notifyListeners();
  }

  Future<void> sortedbyDeceased() async {
    final response = await http.get("https://corona-api.com/countries");
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    sortByDeceased = decoded["data"];

    if (sortByDeceased != null) {
      for (int i = 0; i < sortByDeceased.length; i++) {
        int j = i + 1;

        while (j < sortByDeceased.length) {
          if (sortByDeceased[j]["latest_data"]["deaths"] >
              sortByDeceased[i]["latest_data"]["deaths"]) {
            var x = sortByDeceased[i];
            sortByDeceased[i] = sortByDeceased[j];
            sortByDeceased[j] = x;
          }
          j = j + 1;
        }
      }
    }

    notifyListeners();
  }

  Future<void> countryTimeline(String countryCode) async {
    final response =
        await http.get("https://corona-api.com/countries/$countryCode");
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    final List decodedList = decoded["data"]["timeline"];
    int i = 0;

    print(decodedList);

    if (countryCovidTimeline != []) {
      countryCovidTimeline = [];
    }

    // countryCovidTimeline = decodedList;

    while (i <= decodedList.length) {
      if (int.parse(decodedList[i]["updated_at"].toString().substring(5, 7)) >=
          03) {
        countryCovidTimeline.add(decodedList[i]);
        i += 1;
      } else {
        break;
      }
    }

    notifyListeners();
  }
}
