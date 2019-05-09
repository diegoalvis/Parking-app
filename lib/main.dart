import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';
import 'package:oneparking_citizen/di/app_module.dart';
import 'package:oneparking_citizen/pages/account/login_page.dart';
import 'package:oneparking_citizen/pages/account/phone_page.dart';
import 'package:oneparking_citizen/pages/account/register_one_page.dart';
import 'package:oneparking_citizen/pages/account/register_two_page.dart';
import 'package:oneparking_citizen/pages/main/main_page.dart';
import 'package:oneparking_citizen/pages/splash/splash-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.install(AppModule());
      },
      child: MaterialApp(
        title: 'One Parking',
        theme: AppTheme.build(),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/register-phone': (context) => PhonePage(),
          '/register-one': (context) => RegisterOnePage(),
          '/register-two': (context) => RegisterTwoPage(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
