import 'package:covid_app/assists/size_config.dart';
import 'package:covid_app/providers/covid_data.dart';
import 'package:covid_app/providers/icons_data.dart';
import 'package:covid_app/screens/dashboard.dart';
import 'package:covid_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => CovidData()),
        ChangeNotifierProvider(create: (BuildContext context) => IconsData())
      ],
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              SizeConfig().init(constraints, orientation);
              // print("Constraints : " + constraints.toString());
              // print("Box Height : " + SizeConfig.heightMultiplier.toString());
              // print("Box Width : " + SizeConfig.widthMultiplier.toString());
              // print("text Multiplier (block height) : " +
              //     SizeConfig.textMultiplier.toString());
              // print("image Multiplier (block width) : " +
              //     SizeConfig.imageSizeMultiplier.toString());

              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  title: 'COVID-19',
                  home: DashBoard());
            },
          );
        },
      ),
    );
  }
}
