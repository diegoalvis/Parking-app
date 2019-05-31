import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/data/models/event.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/data/repository/reserve_repository.dart';
import 'package:oneparking_citizen/data/repository/vehicle_repository.dart';
import 'package:oneparking_citizen/data/repository/zone_repository.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_dialog_bloc.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_dialog_events.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_dialog_states.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_reserve_bloc.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/util/widget_util.dart';

class ZoneDialog extends StatelessWidget {
  final Zone _zone;
  final VehicleRepository _repo;
  final ZoneRepository _zoneRepo;
  final ReserveRepository _reserveRepo;

  ZoneDialog(this._zone, this._zoneRepo, this._repo, this._reserveRepo);

  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder
          ..bindSingleton(ZoneDialogBloc(
              _zoneRepo, _repo, InjectorWidget.of(context).get()))
          ..bindSingleton(ZoneReserveBloc(_reserveRepo));
      },
      child: ZoneDialogContent(_zone),
    );
  }
}

class ZoneDialogContent extends StatefulWidget {
  final Zone _zone;

  ZoneDialogContent(this._zone);

  @override
  State<StatefulWidget> createState() => ZoneDialogContentState(_zone);
}

class ZoneDialogContentState extends State<ZoneDialogContent> {
  final Zone _zone;

  ZoneDialogContentState(this._zone);

  ZoneDialogBloc _bloc;

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      _bloc = InjectorWidget.of(context).get();
    }
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ZoneDialogTitle(_zone),
          BlocBuilder(
              bloc: _bloc,
              builder: (ctx, state) {
                if (state is InitialState) {
                  onWidgetDidBuild(() =>
                      _bloc.dispatch(ReadyZone(_zone.idZone, _zone.type)));
                }

                if (state is LoadingState) {
                  return ZoneLoading();
                } else if (state is LoadedState) {
                  return ZoneDetail(
                      state.state, state.vehicle, _zone, state.disability);
                } else if (state is TimeOutState) {
                  return ZoneTimeOut();
                } else if (state is HolyDayState) {
                  return ZoneHolyDay();
                } else if (state is EventState) {
                  return ZoneEvent(state.event);
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }
}

class ZoneLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 50, bottom: 50),
        child: CircularProgressIndicator(),
      );
}

class ZoneDialogTitle extends StatelessWidget {
  final Zone _zone;

  ZoneDialogTitle(this._zone);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 20),
            child: Center(
              child: Text("${_zone.code}",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Theme.of(context).primaryColor)),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${_zone.name}",
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: Colors.white),
                ),
                Text(
                  "${_zone.address}",
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.white),
                ),
              ]),
        ],
      ),
    );
  }
}

class ZoneTimeOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Text(
            "En este momento la zona no tiene tarificación.",
            style: Theme.of(context).textTheme.body1,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Uso Gratuito",
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ),
        ]),
      );
}

class ZoneHolyDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Text(
            "Hoy es Festivo",
            style: Theme.of(context).textTheme.body1,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Uso Gratuito",
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ),
        ]),
      );
}

class ZoneEvent extends StatelessWidget {
  final Event _event;
  final List<String> _months = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  ZoneEvent(this._event);

  String _processDate() {
    final fr = _event.fromDate;
    final to = _event.toDate;

    if (to == null) {
      return "${fr.day} de ${_months[fr.month - 1]}";
    } else {
      bool sameMonth = fr.month == to.month;
      if (sameMonth) {
        return "${fr.day} al ${to.day} de ${_months[fr.month - 1]}";
      } else {
        return "${fr.day} de ${_months[fr.month - 1]} al ${to.day} de ${_months[to.month - 1]}";
      }
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              '${_event.name}',
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              _processDate(),
              style: Theme.of(context).textTheme.body1,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                _event.type == EVENT_FREE ? "Uso Gratuito" : "Uso Prohibido",
                style: Theme.of(context).textTheme.headline.copyWith(
                    color: _event.type == EVENT_FREE
                        ? Theme.of(context).accentColor
                        : Colors.red),
              ),
            ),
          ],
        ),
      );
}

class ZoneDetail extends StatelessWidget with InjectorWidgetMixin {
  final ZoneState _state;
  final Vehicle _vehicle;
  final Zone _zone;
  final bool _disability;

  ZoneDetail(this._state, this._vehicle, this._zone, this._disability);

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (_state.carCells != null && _state.carCells != 0)
                    Expanded(
                      child: CellUsed(
                        Icons.directions_car,
                        "${_state.carCells - _state.usedCarCells}/${_state.carCells}",
                      ),
                    ),
                  if (_state.motorcycleCells != null &&
                      _state.motorcycleCells != 0)
                    Expanded(
                      child: CellUsed(
                        Icons.motorcycle,
                        "${_state.motorcycleCells - _state.usedMotorcycleCells}/${_state.motorcycleCells}",
                      ),
                    ),
                ],
              ),
              if (_state.disabilityCells != null && _state.disabilityCells != 0)
                Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: CellUsed(
                      Icons.accessible,
                      "${_state.disabilityCells - _state.usedDisabilityCells}/${_state.disabilityCells}",
                    )),
            ],
          ),
        ),
        Divider(height: 3),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Icon(_vehicle.type == TYPE_CAR
                  ? Icons.directions_car
                  : Icons.motorcycle),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${_vehicle.plate}",
                      style: Theme.of(context).textTheme.body2,
                    ),
                    if (_vehicle.brand != null)
                      Text(
                        "${_vehicle.brand}",
                        style: Theme.of(context).textTheme.body1,
                      ),
                    Text(
                      _vehicle.type == TYPE_CAR ? "Carro" : "Moto",
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(height: 3),
        BlocBuilder(
          bloc: injector.get<ZoneReserveBloc>(),
          builder: (context, state) {
            if (state is SuccessReserveState) {
              onWidgetDidBuild(() {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/reserve", (Route<dynamic> route) => false);
              });
            }

            if (state is LoadingReserveState) {
              return Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorReserveState) {
              return Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                  child: Text(
                    state.msg,
                    style: Theme.of(context).textTheme.body1.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              );
            } else {
              return Row(
                children: <Widget>[
                  if (_disability)
                    Expanded(
                      child: ReserveButton(
                        "USAR CELDA",
                        icon: Icons.accessible,
                        onTap: () {
                          injector
                              .get<ZoneReserveBloc>()
                              .dispatch(ReserveZone(_zone, true));
                        },
                      ),
                    ),
                  Expanded(
                    child: ReserveButton(
                      "USAR CELDA",
                      icon: Icons.local_parking,
                      onTap: () {
                        injector
                            .get<ZoneReserveBloc>()
                            .dispatch(ReserveZone(_zone, true));
                      },
                    ),
                  ),
                  Expanded(
                    child: ReserveButton(
                      "REPORTAR",
                      icon: Icons.error_outline,
                      onTap: () {
                        Navigator.pushNamed(context, "/report",
                            arguments: _zone);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

class CellUsed extends StatelessWidget {
  final IconData _icon;
  final String _free;

  CellUsed(this._icon, this._free);

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Icon(_icon),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Libres $_free",
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        ],
      );
}

class ReserveButton extends StatelessWidget {
  final String _label;
  final IconData icon;
  final GestureTapCallback onTap;

  ReserveButton(this._label, {this.icon, this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  _label,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      );
}
