import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';
import './pages/main/main_page.dart';
import './pages/account/widgets/login.dart';
import './pages/map/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Parking',
      theme: AppTheme.build(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MainPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/map': (BuildContext context) => MapPage(),
      },
    );
  }
}
