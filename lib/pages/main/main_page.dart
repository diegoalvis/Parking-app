import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:oneparking_citizen/pages/main/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/util/widget_util.dart';
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
              child: BlocBuilder<MainEvent, MainState>(
                bloc: _bloc,
                builder: (context, state) {
                  switch (state) {
                    case MainState.showMap:
                      return MapPage();
                      break;
                    case MainState.showVehicles:
                      return VehiclePage();
                      break;
                    case MainState.showBills:
                      return BillPage();
                      break;
                    case MainState.showInfo:
                      return InfoPage();
                      break;
                    case MainState.logout:
                      onWidgetDidBuild(() => Navigator.pushReplacementNamed(context, '/login'));
                      return SizedBox();
                      break;
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
    final _bloc = InjectorWidget.of(context).get<MainBloc>();
    return Material(
      color: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
      child: new Container(
        width: 50,
        margin: EdgeInsets.only(top: 25),
        child: Column(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    AppIcons.logo,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              onTap: () {},
            ),
            new MenuItem(AppIcons.zone, MainEvent.showMap),
            new MenuItem(AppIcons.vehicle,MainEvent.showVehicles),
            new MenuItem(AppIcons.bill, MainEvent.showBills),
            new MenuItem(AppIcons.info, MainEvent.showInfo),
            Spacer(),
            Material(
              color: Color.fromARGB(0xFF, 0x0A, 0x56, 0xA1),
              child: GestureDetector(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20, right: 10),
                    child: Icon(
                      AppIcons.logout,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                onTap: () => _bloc.dispatch(MainEvent.logout),
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
  final MainEvent event;

  MenuItem(this.icon, this.event);

  MainBloc _bloc;

  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<MainBloc>();
    return GestureDetector(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20, right: 10),
          child: Icon(
            this.icon,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      onTap: () {
        _bloc.dispatch(this.event);
      },
    );
  }
}
