import 'package:covid_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconsData extends ChangeNotifier {
  static Widget iconBuild(String label) {
    return SvgPicture.asset("assets/images/$label.svg",
        height: 80.0, color: AppTheme.accentColor, semanticsLabel: label);
  }

  final List icons = [
    iconBuild("alert"),
    iconBuild("injection"),
    iconBuild("confirm"),
    iconBuild("hospital-bed")
  ];
}
