import 'package:flutter/material.dart';
import 'package:notes_app/assist/size_config.dart';


class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Colors.white;
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color unSelectedTabBackgroundColor = Color(0xFFFFFFFC);
  static const Color subTitleTextColor = Color(0xFF9F988F);
  static const Color primaryColor = Color(0xFF212128);
  static const Color accentColor = Color(0xFFE33357);
  static const Color errorColor = Color(0xFFaa002f);
  static const Color textColor = Colors.black;
  static Color disableColor = Colors.red[300];


  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    primaryColor: AppTheme.primaryColor,
    accentColor: AppTheme.accentColor,
    errorColor: AppTheme.accentColor,
    disabledColor: AppTheme.disableColor,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    textSelectionColor: textColor
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline6: _titleLight,
    subtitle2: _dropDownText,
    button: _buttonLight,
    headline4: _inputLabelText,
    headline1: _brandText,
    bodyText2: _selectedTabLight,
    bodyText1: _unSelectedTabLight,
    headline5: _errorText,
    headline2: _inputText,
    headline3: _brandLogoText,
    subtitle1: _subTitleLight

  );


  static final TextTheme darkTextTheme = TextTheme(
    headline6: _titleDark,
    subtitle2: _subTitleDark,
    button: _buttonDark,
    bodyText2: _selectedTabDark,
    bodyText1: _unSelectedTabDark,
    
  );

  static final TextStyle _titleLight = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 3.35 * SizeConfig.textMultiplier,
  );

  static final TextStyle _subTitleLight = TextStyle(
    color: AppTheme.appBackgroundColor,
    fontWeight: FontWeight.bold,
    fontSize: 2.46 * SizeConfig.textMultiplier,
  );

  static final TextStyle _buttonLight = TextStyle(
    color: AppTheme.accentColor,
    fontSize: 2.01 * SizeConfig.textMultiplier,
  );

  static final TextStyle _inputLabelText = TextStyle(
    color: Colors.white24,
    fontWeight: FontWeight.bold,
    fontSize: 2.46 * SizeConfig.textMultiplier,
  );

  static final TextStyle _inputText = TextStyle(
    color: AppTheme.accentColor,
    fontSize: 2.46 * SizeConfig.textMultiplier,
  );


  static final TextStyle _brandText = TextStyle(
    color: AppTheme.accentColor,
    fontWeight: FontWeight.bold,
    fontSize: 4.24 * SizeConfig.textMultiplier
  );


  static final TextStyle _brandLogoText = TextStyle(
    color: AppTheme.primaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 2.90 * SizeConfig.textMultiplier
  );

  static final TextStyle _dropDownText = TextStyle(
    color: AppTheme.textColor,
    fontSize: 2.01 * SizeConfig.textMultiplier
  );

  
  static final TextStyle _selectedTabLight = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _unSelectedTabLight = TextStyle(
    color: Colors.grey,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _errorText = TextStyle(
    color: AppTheme.accentColor,
    fontSize: 2.68 * SizeConfig.textMultiplier,
  );  

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);

  static final TextStyle _subTitleDark = _subTitleLight.copyWith(color: Colors.white70);

  static final TextStyle _buttonDark = _buttonLight.copyWith(color: Colors.black);



  static final TextStyle _selectedTabDark = _selectedTabDark.copyWith(color: Colors.white);

  static final TextStyle _unSelectedTabDark = _selectedTabDark.copyWith(color: Colors.white70);
}