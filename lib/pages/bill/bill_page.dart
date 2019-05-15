import 'package:flutter/material.dart';
import '../main/main_page.dart';

void main() => runApp(BillPage());

class BillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " Bill page",
            style: Theme.of(context).textTheme.display1,
          )
        ],
      ),
    );
  }
}
