import 'package:flutter/material.dart';
import 'package:practice/pages/login.dart';
import 'package:practice/pages/mainPage.dart';
import 'package:practice/pages/register.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/register';
  static const String mainPage = '/mainPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (context) => RegisterPage(),
        );
      case mainPage:
        return MaterialPageRoute(
          builder: (context) => MainPage(),
        );
      default:
        throw FormatException('Route Not Found!');
    }
  }
}
