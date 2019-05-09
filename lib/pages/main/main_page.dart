import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import '../bill/bill_page.dart';
import '../cash/cash_page.dart';
import '../info/info_page.dart';
import '../map/map_page.dart';
import '../vehicle/vehicle_page.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Parking',
      theme: AppTheme.build(),
      home: DrawerOnly(),
    );
  }
}

class DrawerOnly extends StatelessWidget {
  final bool isOpenDrawer = true;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 80,
      decoration: BoxDecoration(
        color: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
      ),
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
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              child: ListTile(
                leading: new Center(
                  child: const Icon(
                    AppIcons.zone,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                contentPadding: EdgeInsets.all(4.0),
              ),
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => VehiclePage()),
                );
              },
              child: ListTile(
                leading: new Center(
                  child: const Icon(
                    AppIcons.vehicle,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                contentPadding: EdgeInsets.all(4.0),
              ),
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => CashPage()),
                );
              },
              child: ListTile(
                leading: new Center(
                  child: const Icon(
                    AppIcons.wallet,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                contentPadding: EdgeInsets.all(4.0),
              ),
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => BillPage()),
                );
              },
              child: ListTile(
                leading: new Center(
                  child: const Icon(
                    AppIcons.bill,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                contentPadding: EdgeInsets.all(4.0),
              ),
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => InfoPage()),
                );
              },
              child: ListTile(
                leading: new Center(
                  child: const Icon(
                    AppIcons.info,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                contentPadding: EdgeInsets.all(4.0),
              ),
            ),
          ),
          SizedBox(height: 240),
          ListTile(
            leading: new Center(
              child: const Icon(
                AppIcons.info,
                color: Colors.white,
                size: 35,
              ),
            ),
            contentPadding: EdgeInsets.all(4.0),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
