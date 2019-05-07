import 'package:flutter/material.dart';
import '../main/main_page.dart';

void main() => runApp(BillPage());

class BillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Bill page")),
      body: new Text("I belongs to bill Page"),
      drawer: new DrawerOnly(),
    );
  }
}
