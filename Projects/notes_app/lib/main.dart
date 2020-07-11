import 'package:flutter/material.dart';
import 'package:notes_app/Authentication/auth.dart';
import 'package:notes_app/Authentication/authentication_screen.dart';
import 'package:notes_app/Main/home_page.dart';
import 'package:notes_app/Models/date_time.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:provider/provider.dart';

import './Providers/taskList.dart';

//runs the main app
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, TaskList>(
          builder: (ctx, authProvider1, previousTaskList) => TaskList(
              token: authProvider1.token,
              oldTasklist:
                  previousTaskList != null ? previousTaskList.taskList : [],
              userId: authProvider1.userId,
              userName: authProvider1.username),
        ),
        ChangeNotifierProvider(builder: (ctx) => DateTimeProto())
      ],
      child: Consumer<Auth>(
        builder: (ctx, authProvider2, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  SizeConfig().init(constraints, orientation);
                  print("Constraints : " + constraints.toString());
                  print("Box Height : " + SizeConfig.heightMultiplier.toString());
                  print("Box Width : " + SizeConfig.widthMultiplier.toString());
                  print("text Multiplier (block height) : " + SizeConfig.textMultiplier.toString()); 
                  print("image Multiplier (block width) : " + SizeConfig.imageSizeMultiplier.toString()); 

                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.lightTheme,
                    home: authProvider2.isAuth
                        ? HomePage()
                        : FutureBuilder(
                            future: authProvider2.autoLogin(),
                            builder: (ctx, autoLoginResult) =>
                                AuthenticationScreen(),
                          ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
