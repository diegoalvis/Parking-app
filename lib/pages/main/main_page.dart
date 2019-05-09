import 'package:flutter/material.dart';
import 'package:oneparking_citizen/util/app-icons.dart';

void main() => runApp(MaterialApp(home: MainPage()));

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
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
            " Main page",
            style: Theme.of(context).textTheme.display1,
          )
        ],
      ),
    );
  }
}

class DrawerOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
      child: new Container(
        width: 80,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: new Center(
                child: const Icon(
                  AppIcons.logo,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              contentPadding: EdgeInsets.all(5.0),
            ),
            new MenuItem(AppIcons.zone, context, '/map'),
            new MenuItem(AppIcons.vehicle, context, '/vehicle'),
            new MenuItem(AppIcons.bill, context, '/bill'),
            new MenuItem(AppIcons.info, context, '/info'),
            SizedBox(height: 300),
            Material(
              color: Color.fromARGB(0xFF, 0x0A, 0x56, 0xA1),
              child: ListTile(
                leading: new Center(
                  child: const Icon(
                    AppIcons.logout,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                contentPadding: EdgeInsets.all(5.0),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String route;
  final BuildContext context;

  MenuItem(this.icon, this.context, this.route);

  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Center(
        child: new Icon(
          this.icon,
          color: Colors.white,
          size: 35,
        ),
      ),
      contentPadding: EdgeInsets.all(4.0),
      onTap: () {
        Navigator.of(this.context).pushNamed(this.route);
      },
    );
  }
}
