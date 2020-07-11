import 'package:covid_app/assists/size_config.dart';
import 'package:flutter/material.dart';

class Appbar{

  static PreferredSizeWidget appBar(BuildContext context){
    return AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4.0,
        title:Expanded(
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.23 * SizeConfig.heightMultiplier),
                child: Text("COVID-19", style: Theme.of(context).textTheme.headline1),
              ),
            ],
          ),
        ),
      );
  }

}