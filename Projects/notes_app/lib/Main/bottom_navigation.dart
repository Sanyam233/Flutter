import 'package:flutter/material.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';

import 'to_do_pop_up.dart';

class BottomNavigation extends StatelessWidget {
  final int indexVal;

  BottomNavigation(this.indexVal);

  



  @override
  Widget build(BuildContext context) {

    
    return BottomNavigationBar(elevation: 0.0,
      currentIndex: indexVal,
      onTap: (val){
        if(val == 1){
          return showDialog(
            context: context,
            builder: (_) {
              return ToDoPopUp();
            });
        }

        return val;

      },
      unselectedItemColor: Colors.grey,
      selectedItemColor: AppTheme.accentColor,
      backgroundColor: AppTheme.primaryColor,
      items: [
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(Icons.home, size: 3.35 * SizeConfig.heightMultiplier),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle, color: AppTheme.accentColor, size: 7.81 * SizeConfig.heightMultiplier),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, size:  3.35 * SizeConfig.heightMultiplier),
          title: Text(""),
        ),
      ],
    );
  }
}


