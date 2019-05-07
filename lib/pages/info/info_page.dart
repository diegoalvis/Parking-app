import 'package:flutter/material.dart';
import '../main/main_page.dart';

void main() => runApp(InfoPage());

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Info page")),
      body: new Text("I belongs to info Page"),
      drawer: new DrawerOnly(),
    );
  }
}
