import 'package:flutter/material.dart';
import '../main/main_page.dart';

void main() => runApp(MapPage());

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Map page")),
      body: new Text("I belongs to map Page"),
      drawer: new Container(
        width: 80,
        child: new DrawerOnly(),
      ),
    );
  }
}
