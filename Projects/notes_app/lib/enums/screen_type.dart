//creating an enum for screen type
import 'package:flutter/material.dart';

enum DeviceScreenType {Desktop, Mobile, Tablet}


DeviceScreenType getDeviceScreenType(MediaQueryData mediaQueryData){

  var deviceOrientation = mediaQueryData.orientation;

  double deviceWidth = 0;

  if (deviceOrientation == Orientation.landscape){

    deviceWidth = mediaQueryData.size.height;

  }else{

    deviceWidth = mediaQueryData.size.width;

  }

  //setting break points to assign a value
  if (deviceWidth > 950){

    return DeviceScreenType.Desktop;

  }else if (deviceWidth > 600){


    return DeviceScreenType.Tablet;


  }else{

    return DeviceScreenType.Mobile;

  }




}