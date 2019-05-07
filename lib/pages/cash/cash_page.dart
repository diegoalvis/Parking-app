import 'package:flutter/material.dart';
import '../main/main_page.dart';

void main() => runApp(CashPage());

class CashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Cash page")),
      body: new Text("I belongs to Cash Page"),
      drawer: new DrawerOnly(),
    );
  }
}
