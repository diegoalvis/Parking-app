import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Parking',
      theme: AppTheme.build(),
      //home: SplashPage(),
    );
  }
}
