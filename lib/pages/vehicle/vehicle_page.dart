import 'package:flutter/material.dart';
import '../main/main_page.dart';

void main() => runApp(VehiclePage());

class VehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Vehicle page")),
      body: new Text("I belongs to vehicle Page"),
      drawer: new DrawerOnly(),
    );
  }
}
