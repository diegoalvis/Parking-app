import 'package:flutter/material.dart';
import '../main/main_page.dart';

void main() => runApp(InfoPage());

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: new DrawerOnly()),
            ],
          ),
          Text(
            " Info page",
            style: Theme.of(context).textTheme.display1,
          )
        ],
      ),
    );
  }
}
