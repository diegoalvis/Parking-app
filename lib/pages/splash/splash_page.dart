import 'dart:async';

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import 'package:oneparking_citizen/widgets/app-background.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  UserSession _session;

  @override
  Widget build(BuildContext context) {
    _session = InjectorWidget.of(context).get();
    waitTime();
    return AppTheme.darkTheme(child: SplashContent());
  }

  void waitTime() async {
    await Future.delayed(Duration(seconds: 2));
    final logged = await _session.logged;
    if (!logged) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      final isReserving = await _session.isReserving;
      if(isReserving){
        Navigator.pushReplacementNamed(context, '/reserve' );
      }else{
        final toDay = await _session.toDay;
        final now = DateTime.now();
        if(toDay == "${now.day}_${now.month}" ){
          Navigator.pushReplacementNamed(context, '/main' );
        }else{
          Navigator.pushReplacementNamed(context, '/loader' );
        }


      }
    }
  }
}

class SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Icon(
              AppIcons.logo,
              color: Colors.white,
              size: 120,
            ),
          ),
          Text("OneParking", style: Theme.of(context).textTheme.display3),
        ],
      ),
    );
  }
}
