import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import 'package:oneparking_citizen/widgets/app-background.dart';

class AccountBase extends StatelessWidget {
  final Widget child;

  AccountBase({this.child});

  @override
  Widget build(BuildContext context) =>
      AppTheme.darkTheme(child: AccountContent(child: child));
}

class AccountContent extends StatelessWidget {
  final Widget child;

  AccountContent({this.child});

  @override
  Widget build(BuildContext context) => AppBackground(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Icon(AppIcons.logo, color: Colors.white, size: 60),
                  ),
                  Text('OneParking',
                      style: Theme.of(context).textTheme.display1)
                ],
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 60, bottom: 20),
                  child: child,
                ),
              ),
            )
          ],
        ),
      );
}
