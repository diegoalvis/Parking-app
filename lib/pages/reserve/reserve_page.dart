import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        binder.bindSingleton(ReserveBloc(InjectorWidget.of(context).get()));
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

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<ReserveBloc>();
    Reserve reserve;
    Duration parkingTime;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reserva",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Builder(
        builder: (BuildContext context) {
          _bloc.errorStream.listen((msg) => Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg))));
          return Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: BlocBuilder(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is InitialState) {
                    _bloc.dispatch(ReserveEvent(ReserveEventType.getActive));
                  }
                  if (state is NoReservesState) {
                    goToSplash();
                    return Center(child: Text("No posee reservas en el momento."));
                  }
                  if (state is SuccessState<Reserve>) {
                    reserve = state.data;
                    parkingTime = DateTime.now().difference(reserve?.date);
                    //parkingTime = Duration(hours: 3, minutes: 59, seconds: 52);
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
                              : Column(
                                  children: <Widget>[
                                    Expanded(child: buildTimeWidget(state, parkingTime)),
                                    Expanded(
                                      child: StreamBuilder<int>(
                                          stream: _bloc.valueStream,
                                          initialData: 0,
                                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                            return Text(
                                              "\$ ${snapshot.data}",
                                              style: TextStyle(fontSize: 30.0, color: Colors.blue),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      DescriptionPlace(
                          icon: reserve?.type == TYPE_MOTORCYCLE ? Icons.motorcycle : AppIcons.vehicle,
                          titleDescription: "Placa",
                          content: reserve?.plate ?? ""),
                      Divider(),
                      DescriptionPlace(icon: Icons.place, titleDescription: "Nombre de la Zona", content: reserve?.address ?? ""),
                      Align(
                        alignment: Alignment.centerRight,
                        child: StopButton(
                          onPressed:
                              state is FinishReserveState ? null : () => _bloc.dispatch(ReserveEvent(ReserveEventType.stop)),
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
            child: Text("Ud no tiene reservas en este momento", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)));
      }
    } else if (state is FinishReserveState) {
      return Center(
          child: Text("Reserva finalizada.\nDirijase hacia el asistente en via para pagar.",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)));
    }

    return CounterDown(
        stop: state is FinishReserveState,
        initialTime: parkingTime,
        onTimeIncremented: (minutes) {
          _bloc.dispatch(ReserveEvent(ReserveEventType.getValue, data: minutes));
        });
  }

  void goToSplash() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/');
  }
}
