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
      if (isReserving) {
        Navigator.pushReplacementNamed(context, '/reserve');
      } else {
        final toDay = await _session.toDay;
        final now = DateTime.now();

        _session.setLastLoc(null);

        if (toDay == "${now.day}_${now.month}") {
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          Navigator.pushReplacementNamed(context, '/loader');
        }
      }
    }
  }
}

class SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              AppIcons.logo_white,
              color: Colors.white,
              size: 200,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 150,
                  child: Image(
                    image: AssetImage('assets/images/escudo_white.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 30),
                  child: Text(
                    "Powered By EzLife Corp",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
