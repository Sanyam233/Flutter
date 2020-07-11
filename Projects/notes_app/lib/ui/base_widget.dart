import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_app/enums/screen_type.dart';
import 'package:notes_app/ui/device_information.dart';

class BaseWidget extends StatelessWidget {
  
  //the class takes in a function
  final Widget Function(BuildContext ctx, DeviceInformation deviceInformation)
      builder;

  const BaseWidget({this.builder});

  @override
  Widget build(BuildContext context) {

    //field's values defined
    var mediaQuery = MediaQuery.of(context);
    var orientation = mediaQuery.orientation;
    var platform = Platform.operatingSystem;
    var screenType = getDeviceScreenType(mediaQuery);

    /*layout builder wraps the builder function that is to be returned
    mainly it is done to get values of widget constraints that is a named field inside the 
    DeviceInformation
    */

    return LayoutBuilder(
      
      builder: (BuildContext context, BoxConstraints constraints) {
      var deviceInformation = DeviceInformation(
          orientation: orientation,
          platform: platform,
          screenSize: Size(mediaQuery.size.width, mediaQuery.size.height),
          statusBar: mediaQuery.padding.top,
          screenType: screenType,
          widgetSize: Size(constraints.maxWidth, constraints.maxHeight));

      return builder(context, deviceInformation); //return the build function
    });
  }
}
