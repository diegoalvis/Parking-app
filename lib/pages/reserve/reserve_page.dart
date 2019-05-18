import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/util/widget_util.dart';

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
    int values = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reserva",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is SuccessState<Reserve>) {
                reserve = state.data;
                //parkingTime = DateTime.now().difference(reserve.date);
                parkingTime = Duration(minutes: 29, seconds: 54);
              }
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              //color: Color.fromRGBO(229, 229, 229, 1),

              return Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(229, 229, 229, 1),
                      child: parkingTime == null
                          ? SizedBox()
                          : Column(
                              children: <Widget>[
                                Expanded(
                                  child: CounterDown(
                                      initialTime: parkingTime,
                                      value: values,
                                      onTimeIncremented: (minutes) {
                                        _bloc.dispatch(ReserveEvent(ReserveEventType.getValue, data: minutes));
                                      }),
                                ),
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
                  DescriptionPlace(icon: Icons.motorcycle, titleDescription: "Placa", content: reserve?.plate ?? ""),
                  Divider(),
                  DescriptionPlace(icon: Icons.place, titleDescription: "Nombre de la Zona", content: reserve?.address ?? ""),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: StopButton(),
    );
  }
}
