import 'package:flutter/material.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:oneparking_citizen/pages/main/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../vehicle/vehicle_page.dart';
import '../map/map_page.dart';
import '../bill/bill_page.dart';
import '../info/info_page.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  MainBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<MainBloc>();
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: new DrawerOnly()),
            ],
          ),
          Expanded(
            child: Container(
              child: BlocBuilder(
                bloc: _bloc,
                builder: (context, state) {
                  switch (state) {
                    case 1:
                      return MapPage();
                      break;
                    case 2:
                      return VehiclePage();
                      break;
                    case 3:
                      return BillPage();
                      break;
                    default:
                      return InfoPage();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Material(
        color: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
        child: new Container(
          width: 50,
          margin: EdgeInsets.only(top: 20),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: new Center(
                  child: const Icon(
                    AppIcons.logo,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                contentPadding: EdgeInsets.all(5.0),
              ),
              new MenuItem(AppIcons.zone, context, 1),
              new MenuItem(AppIcons.vehicle, context, 2),
              new MenuItem(AppIcons.bill, context, 3),
              new MenuItem(AppIcons.info, context, 4),
              SizedBox(height: 300),
              Material(
                color: Color.fromARGB(0xFF, 0x0A, 0x56, 0xA1),
                child: ListTile(
                  leading: new Center(
                    child: const Icon(
                      AppIcons.logout,
                      color: Colors.white,
                      size: 25,
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
  final int index;
  final BuildContext context;

  MenuItem(this.icon, this.context, this.index);

  MainBloc _bloc;

  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<MainBloc>();
    return ListTile(
      leading: Center(
        child: Icon(
          this.icon,
          color: Colors.white,
          size: 25,
        ),
      ),
      contentPadding: EdgeInsets.all(4.0),
      onTap: () {
        _bloc.dispatch(this.index);
      },
    );
  }
}
