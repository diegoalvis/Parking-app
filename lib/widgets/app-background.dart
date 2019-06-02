import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  AppBackground({this.child});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: child,
      );
}
