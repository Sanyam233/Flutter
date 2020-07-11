import 'package:flutter/material.dart';
import 'package:notes_app/Authentication/auth.dart';
import 'package:notes_app/Page_One/edit_profile.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:notes_app/ui/base_widget.dart';
import 'package:provider/provider.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  static double _heightMultiplier = SizeConfig.heightMultiplier;
  static double _widthMultiplier = SizeConfig.widthMultiplier;

  bool editMode = false;

  Widget _listTileBuilder(
      BuildContext context, String title, IconData icon, Function func) {
    return Padding(
      padding: EdgeInsets.only(
          left: 3.62 * _widthMultiplier, top: 3.35 * _heightMultiplier),
      child: ListTile(
        enabled: true,
        onTap: () {},
        leading: IconButton(
          icon: Icon(
            icon,
            color: AppTheme.accentColor,
            size: 3.13 * _heightMultiplier,
          ),
          onPressed: func,
        ),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(fontSize: 2.23 * _heightMultiplier)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, deviceInfo) {
        var widgetHeight = deviceInfo.widgetSize.height;
        var widgetWidth = deviceInfo.widgetSize.width;

        return editMode
            ? EditProfileScreen()
            : Container(
                height: widgetHeight,
                width: widgetWidth,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 16.74 * _heightMultiplier,
                      padding: EdgeInsets.only(
                          top: 3.35 * _heightMultiplier,
                          left: 4.83 * _widthMultiplier),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    6.70 * _heightMultiplier),
                                child: Image.network(
                                    "https://pwcenter.org/sites/default/files/default_images/default_profile.png"),
                              ),
                              backgroundColor: AppTheme.accentColor,
                              maxRadius: 14.49 * _widthMultiplier),
                          if (editMode == false)
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 6.14 * _heightMultiplier,
                                  left: 3.14 * _widthMultiplier),
                              child: Text(Provider.of<Auth>(context).username,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                          fontSize: 3.35 * _heightMultiplier)),
                            ),
                        ],
                      ),
                    ),
                    _listTileBuilder(
                      context,
                      "Edit Profile",
                      Icons.edit,
                      () {
                        setState(
                          () {
                            editMode = true;
                          },
                        );
                      },
                    ),
                    _listTileBuilder(
                      context,
                      "Logout",
                      Icons.exit_to_app,
                      () {
                        Navigator.of(context).pushReplacementNamed("/");
                        Provider.of<Auth>(context, listen: false).logout();
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}
