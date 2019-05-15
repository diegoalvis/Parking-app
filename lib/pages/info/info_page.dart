import 'package:flutter/material.dart';

void main() => runApp(InfoPage());

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " Info page",
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }
}
