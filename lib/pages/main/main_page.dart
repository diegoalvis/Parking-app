import 'dart:async';

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/data/repository/vehicle_repository.dart';
import 'package:oneparking_citizen/data/repository/zone_repository.dart';
import 'package:oneparking_citizen/data/repository/reserve_repository.dart';
import 'package:oneparking_citizen/pages/main/main_bloc.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_dialog.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import 'package:oneparking_citizen/util/dialog-util.dart';
import 'package:oneparking_citizen/util/widget_util.dart';

import '../bill/bill_page.dart';
import '../info/info_page.dart';
import '../map/map_page.dart';
import '../vehicle/vehicle_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  MainBloc _bloc;
  DialogUtil _dialogUtil;
  StreamSubscription _subs;

  @override
  void initState() {
    super.initState();
    onWidgetDidBuild(() {
      _subs = _dialogUtil.open.listen((s) {
        showModalBottomSheet(
          context: context,
          builder: (ctx) {
            ZoneRepository repo = InjectorWidget.of(context).get();
            VehicleRepository vehicleRepository =
                InjectorWidget.of(context).get();
            ReserveRepository reserveRepository =
                InjectorWidget.of(context).get();
            return ZoneDialog(s, repo, vehicleRepository, reserveRepository);
          },
        );
      });
    });
  }

  @override
  void dispose() {
    _subs?.cancel();
    _bloc?.dispose();
    _dialogUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_bloc == null){
      _bloc = InjectorWidget.of(context).get();
    }

    if(_dialogUtil == null){
      _dialogUtil = InjectorWidget.of(context).get();
    }

    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: new DrawerOnly(_bloc)),
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
                      onWidgetDidBuild(() => Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (Route<dynamic> route) => false));
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

  final MainBloc _bloc;
  DrawerOnly(this._bloc);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
      child: new Container(
        width: 50,
        margin: EdgeInsets.only(top: 25),
        child: Column(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  AppIcons.logo,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            new MenuItem(AppIcons.zone, MainEvent.showMap, _bloc),
            new MenuItem(AppIcons.vehicle, MainEvent.showVehicles, _bloc),
            new MenuItem(AppIcons.bill, MainEvent.showBills, _bloc),
            new MenuItem(AppIcons.info, MainEvent.showInfo, _bloc),
            Spacer(),
            Material(
              color: Color.fromARGB(0xFF, 0x0A, 0x56, 0xA1),
              child: GestureDetector(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 20, bottom: 20, right: 10),
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
  final MainBloc _bloc;

  MenuItem(this.icon, this.event, this._bloc);



  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 20, bottom: 20, right: 10),
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
