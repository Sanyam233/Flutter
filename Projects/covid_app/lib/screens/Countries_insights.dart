import 'package:covid_app/providers/covid_data.dart';
import 'package:covid_app/widgets/country_insight_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountriesInsights extends StatefulWidget {
  @override
  _CountriesInsightsState createState() => _CountriesInsightsState();
}

class _CountriesInsightsState extends State<CountriesInsights> {
  bool _fetchData = true;
  var covidCountryData;
  List countryWiseStats;
  TextEditingController controller = TextEditingController();
  String filter;
  int _swipeIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_fetchData == true) {
      covidCountryData =
          Provider.of<CovidData>(context, listen: true).fetchCountryWiselData();
      _fetchData = false;
    }

    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  OutlineInputBorder _searchBar() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide:
          BorderSide(width: 1.0, color: Colors.black, style: BorderStyle.solid),
    );
  }

  void _swipeState() {
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        _swipeIndex = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    countryWiseStats =
        Provider.of<CovidData>(context, listen: false).countryWiseStats;
    return Scaffold(
      body: countryWiseStats == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onVerticalDragDown: (val) => _swipeState(),
              dragStartBehavior: DragStartBehavior.down,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: _swipeIndex == 0 ? 10.0 : 15.0),
                    if (_swipeIndex == 1)
                      Container(
                        height: 40,
                        width: 340,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextField(
                          cursorColor: Theme.of(context).accentColor,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding:
                                EdgeInsets.only(bottom: 5.0, left: 8.0),
                            labelText: "Search....",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.grey),
                            enabledBorder: _searchBar(),
                            focusedBorder: _searchBar(),
                            border: _searchBar(),
                          ),
                          controller: controller,
                        ),
                      ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Expanded(
                      child: CountryInsightsWidget(
                          countryWiseStats, countryWiseStats.length, filter),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
