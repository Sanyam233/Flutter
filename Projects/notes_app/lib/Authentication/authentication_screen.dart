import 'package:flutter/material.dart';
import 'package:notes_app/Authentication/auth.dart';
import 'package:notes_app/Models/http_error_generator.dart';
import 'package:notes_app/assist/size_config.dart';
import 'package:notes_app/assist/styling.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  var _isLoading = false;

  static double _heightMultiplier = SizeConfig.heightMultiplier;
  static double _widthMultiplier = SizeConfig.widthMultiplier;

  double paddingValue = 31.25 * _heightMultiplier;
  double paddingval = 1.67 * _heightMultiplier;
  double paddingVal2 = 1.21 * _widthMultiplier;
  double emailPadding = 1.21 * _widthMultiplier;
  double emailContentPadding = 1.67 * _heightMultiplier;
  double passwordPadding = 1.21 * _widthMultiplier;
  double passwordContentPadding = 1.67 * _heightMultiplier;
  double confirmPasswordPadding = 1.21 * _widthMultiplier;
  double confirmPasswordContentPadding = 1.67 * _heightMultiplier;

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    "username": " ",
    "email": " ",
    "password": " "
  };

  final _formKey = GlobalKey<FormState>();
  final _passwordConfirmation = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
  }

  void switchScreens() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
        paddingValue = 22.32 * _heightMultiplier;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        paddingValue = 31.25 * _heightMultiplier;
      });
    }
  }

  _displayErrorMessage(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Authentication Failed",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
          content: Text(
            errorMessage,
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 20),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Okay",
                style: Theme.of(context).textTheme.button,
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> savingData() async {
    final _validation = _formKey.currentState.validate();

    if (!_validation) {
      return;
    }

    _formKey.currentState.save();

    setState(
      () {
        _isLoading = true;
      },
    );

    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData["email"], _authData["password"]);
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData["email"], _authData["password"], _authData["username"]);
      }
    } on HttpErrorGenerator catch (error) {
      var errorMessage = "Authentication failed";

      if (error.errorMessage.contains("EMAIL_EXISTS")) {
        errorMessage = "This email address is already used";
      } else if (error.errorMessage.contains("INVALID_EMAIL")) {
        errorMessage = "Email doesnot exists";
      } else if (error.errorMessage.contains("WEAK_PASSWORD")) {
        errorMessage = "Weak Password";
      } else if (error.errorMessage.contains("EMIAL_NOT_FOUND")) {
        errorMessage = "Email couldn't be found";
      } else if (error.errorMessage.contains("INVALID_PASSWORD")) {
        errorMessage = "Wrong password";
      }

      _displayErrorMessage(errorMessage);
    } catch (error) {
      var errorMessage = "Authentication failed. Please try again Later";

      _displayErrorMessage(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceInfo = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: deviceInfo.height,
          width: deviceInfo.width,
          color: AppTheme.primaryColor,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  child: AnimatedPadding(
                    padding: EdgeInsets.only(top: paddingValue),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "T",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 0.56 * _heightMultiplier),
                          child: Icon(Icons.list,
                              color: AppTheme.accentColor,
                              size: 5.58 * SizeConfig.textMultiplier),
                        ),
                        Text(
                          "Do",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  Padding(
                    padding: EdgeInsets.only(top: 1.67 * _heightMultiplier),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 4.83 * _widthMultiplier,
                          bottom: 0.56 * _heightMultiplier),
                      height: 6.70 * _heightMultiplier,
                      width: 72.46 * _widthMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border:
                            Border.all(width: 2.0, color: AppTheme.accentColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: paddingVal2, left: 1.21 * _widthMultiplier),
                        child: TextFormField(
                          style: Theme.of(context).textTheme.headline2,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.start,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          onSaved: (value) => _authData["username"] = value,
                          cursorColor: AppTheme.accentColor,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: paddingval),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: InputBorder.none,
                              labelText: "Username",
                              labelStyle:
                                  Theme.of(context).textTheme.headline4),
                          validator: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                paddingval = 0 * _heightMultiplier;
                                paddingVal2 = 2.23 * _heightMultiplier;
                              });
                              return "Enter a username";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 1.67 * _heightMultiplier),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 4.83 * _widthMultiplier,
                        bottom: 0.56 * _heightMultiplier),
                    height: 6.70 * _heightMultiplier,
                    width: 72.46 * _widthMultiplier,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border:
                          Border.all(width: 2.0, color: AppTheme.accentColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: emailPadding, left: 5.0),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.headline2,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        focusNode: _emailFocusNode,
                        onSaved: (value) => _authData["email"] = value,
                        cursorColor: AppTheme.accentColor,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: emailContentPadding),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                            labelText: "Email",
                            labelStyle: Theme.of(context).textTheme.headline4),
                        validator: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              emailContentPadding = 0 * _heightMultiplier;
                              emailPadding = 2.23 * _heightMultiplier;
                            });
                            return "Enter an email";
                          } else {
                            String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                                "\\@" +
                                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                                "(" +
                                "\\." +
                                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                                ")+";
                            RegExp regExp = new RegExp(p);

                            if (regExp.hasMatch(value)) {
                              return null;
                            } else {
                              setState(
                                () {
                                  emailContentPadding = 0 * _heightMultiplier;
                                  emailPadding = 2.23 * _heightMultiplier;
                                },
                              );

                              return "Enter a vaild email";
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.67 * _heightMultiplier),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 4.83 * _widthMultiplier,
                        bottom: 0.56 * _heightMultiplier),
                    height: 6.70 * _heightMultiplier,
                    width: 72.46 * _widthMultiplier,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border:
                          Border.all(width: 2.0, color: AppTheme.accentColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: passwordPadding, left: 1.21 * _widthMultiplier),
                      child: TextFormField(
                        obscureText: true,
                        style: Theme.of(context).textTheme.headline2,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_confirmPasswordFocusNode),
                        onSaved: (value) => _authData["password"] = value,
                        controller: _passwordConfirmation,
                        cursorColor: AppTheme.accentColor,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: passwordContentPadding),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                            labelText: "Password",
                            labelStyle: Theme.of(context).textTheme.headline4),
                        validator: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              passwordPadding = 2.23 * _heightMultiplier;
                              passwordContentPadding = 0 * _heightMultiplier;
                            });
                            return "Enter a password";
                          } else if (value.length < 6) {
                            setState(() {
                              passwordPadding = 2.23 * _heightMultiplier;
                              passwordContentPadding = 0 * _heightMultiplier;
                            });
                            return "Password to weak";
                          }
                          setState(() {
                            passwordPadding = 0.56 * _heightMultiplier;
                            passwordContentPadding = 1.67 * _heightMultiplier;
                          });

                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  Padding(
                    padding: EdgeInsets.only(top: 1.67 * _heightMultiplier),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 4.83 * _widthMultiplier,
                          bottom: 0.56 * _heightMultiplier),
                      height: 6.70 * _heightMultiplier,
                      width: 72.46 * _widthMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border:
                            Border.all(width: 2.0, color: AppTheme.accentColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: confirmPasswordPadding,
                          left: 1.21 * _widthMultiplier,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          style: Theme.of(context).textTheme.headline2,
                          cursorColor: AppTheme.accentColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: confirmPasswordContentPadding),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                            labelText: "Confirm Password",
                            labelStyle: Theme.of(context).textTheme.headline4,
                          ),
                          validator: (value) {
                            if (value != _passwordConfirmation.text) {
                              setState(() {
                                confirmPasswordContentPadding =
                                    0 * _heightMultiplier;
                                confirmPasswordPadding =
                                    2.23 * _heightMultiplier;
                              });
                              return "Password do not match";
                            }

                            confirmPasswordContentPadding =
                                1.67 * _heightMultiplier;
                            confirmPasswordPadding = 0.56 * _heightMultiplier;

                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 2.79 * _heightMultiplier),
                  child: _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () => savingData(),
                          child: Container(
                            alignment: Alignment.center,
                            height: 4.46 * _heightMultiplier,
                            width: 29 * _widthMultiplier,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.0, color: AppTheme.accentColor),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Text(
                              _authMode == AuthMode.Login ? "Login" : "Sign in",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                ),
                if (_isLoading == false)
                  FlatButton(
                    onPressed: () => switchScreens(),
                    child: Text(
                      _authMode == AuthMode.Login ? "Sign Up" : "Log in",
                      style: Theme.of(context).textTheme.button,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
