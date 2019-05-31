import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import 'package:oneparking_citizen/util/state-util.dart';

import './widgets/counter_down.dart';
import './widgets/description_place.dart';
import './widgets/stop_button.dart';
import 'reserve_bloc.dart';

class ReservePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        final inj = InjectorWidget.of(context);
        binder.bindFactory((injector, params) =>
            ReserveBloc(inj.get(), inj.get()));
      },
      child: ReserveContainer(),
    );
  }
}

class ReserveContainer extends StatefulWidget {
  _ReserveContainerState createState() => _ReserveContainerState();
}

class _ReserveContainerState extends State<ReserveContainer> {
  ReserveBloc _bloc;
  NumberFormat _numberFormat =
      NumberFormat.currency(decimalDigits: 0, symbol: "\$ ");

  @override
  void dispose() {
    _bloc?.dispose();
    _bloc = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null){
      _bloc = InjectorWidget.of(context).get<ReserveBloc>();
    }
    Reserve reserve;
    Duration parkingTime;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reserva",
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          _bloc.errorStream.listen((msg) =>
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg))));
          return Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: BlocBuilder(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is InitialState) {
                    _bloc.dispatch(ReserveEvent(ReserveEventType.getActive));
                  }
                  if (state is NoReservesState) {
                    goToSplash();
                    return Center(
                        child: Text("No posee reservas en el momento."));
                  }
                  if (state is SuccessState<Reserve>) {
                    reserve = state.data;
                    parkingTime = DateTime.now().difference(reserve?.date);
                    //parkingTime = Duration(hours: 3, minutes: 59, seconds: 52);
                  }

                  if(state is FinishReserveState && reserve == null){
                    reserve = state.reserve;
                    parkingTime = Duration(seconds: 10);
                  }

                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Color.fromRGBO(229, 229, 229, 1),
                          child: parkingTime == null
                              ? SizedBox()
                              : Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      buildTimeWidget(state, parkingTime),
                                      StreamBuilder<int>(
                                          stream: _bloc.valueStream,
                                          initialData: 0,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<int> snapshot) {
                                            return Text(
                                              _numberFormat
                                                  .format(snapshot.data),
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  color: Colors.blue),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      DescriptionPlace(
                          icon: reserve?.type == TYPE_MOTORCYCLE
                              ? Icons.motorcycle
                              : AppIcons.vehicle,
                          titleDescription: "Placa",
                          content: reserve?.plate ?? ""),
                      Divider(),
                      DescriptionPlace(
                          icon: Icons.place,
                          titleDescription: "Nombre de la Zona",
                          content: reserve?.address ?? ""),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: FlatButton(
                                child: Text(
                                  "Refrescar",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                                onPressed: (){
                                  _bloc.dispatch(ReserveEvent(ReserveEventType.getActive));
                                },
                              ),
                            ),
                            StopButton(
                              state is FinishReserveState
                                  ? 'Regresar'
                                  : 'Detener',
                              onPressed: state is FinishReserveState
                                  ? () => Navigator.pushReplacementNamed(
                                      context, '/main')
                                  : () => _bloc.dispatch(
                                      ReserveEvent(ReserveEventType.stop)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTimeWidget(BaseState state, Duration parkingTime) {
    if (state is SuccessState<Reserve>) {
      final reserve = state.data;
      if (reserve == null) {
        return Center(
            child: Text("Ud no tiene reservas en este momento",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)));
      }
    } else if (state is FinishReserveState) {
      return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "Reserva finalizada",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Center(
              child: Text(
                "Dirijase hacia el asistente en via para pagar.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),
      );
    }

    return CounterDown(
        stop: state is FinishReserveState,
        initialTime: parkingTime,
        onTimeIncremented: (minutes) {
          _bloc
              .dispatch(ReserveEvent(ReserveEventType.getValue, data: minutes));
        });
  }

  void goToSplash() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/main');
  }
}
