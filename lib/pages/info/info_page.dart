import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/data/models/config.dart';
import 'package:oneparking_citizen/data/repository/info_repository.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import './widgets/day_hour_column.dart';
import './widgets/table_prices.dart';
import './widgets/title_section.dart';
import 'info_bloc.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindSingleton(InfoBloc(InjectorWidget.of(context).get()));
      },
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: InfoContainer()),
    );
  }
}

class InfoContainer extends StatefulWidget {
  _InfoContainerState createState() => _InfoContainerState();
}

class _InfoContainerState extends State<InfoContainer> {
  InfoBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<InfoBloc>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Información",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              Info info;
              if (state is InitialState) {
                _bloc.dispatch(InfoEvent.fetchData);
              }
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is SuccessState<Info>) {
                info = state.data;
              }
              return info == null
                  ? Center(child: Text("No hay informacion disponible"))
                  : ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: buildPriceSection(info.config),
                        ),
                        Divider(height: 36, color: Colors.black),
                        TitleSection(textTitle: "Zonas comerciales"),
                        Column(
                          children: info.businessSchedules
                              .map((item) => DayHourColumn(
                                  days: item.label, times: item.times))
                              .toList(),
                        ),
                        Divider(height: 36, color: Colors.black),
                        TitleSection(textTitle: "Zonas residenciales"),
                        Column(
                          children: info.residentialSchedules
                              .map((item) => DayHourColumn(
                                  days: item.label, times: item.times))
                              .toList(),
                        ),
                      ],
                    );
            }));
  }

  Widget buildPriceSection(Config config) => Column(
        children: <Widget>[
          TitleSection(textTitle: "Precios"),
          TablePrices(
            baseCar: "\$ ${config.basePrice ?? ""}",
            fractionCar: "\$ ${config.fractionPrice ?? ""}",
            baseMoto: "\$ ${config.mcBasePrice ?? ""}",
            fractionMoto: "\$ ${config.mcFractionPrice ?? ""}",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 15.0),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(text: "Tiempo base de parqueo es "),
                  TextSpan(
                      text: "${config.baseTime} min",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " y cada fracción adicional es de "),
                  TextSpan(
                      text: "${config.fractionTime} min.",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          if (config.limitTime != 0)
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan( text:"Si retiras tu vehiculo en los primeros "),
                    TextSpan( text:"${config.limitTime} min", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan( text:" el uso del espacio es gratuito."),
                  ],
                ),
              ),
            )
        ],
      );
}
