import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/data/models/bill.dart';
import 'package:oneparking_citizen/data/repository/bill_repository.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import 'package:oneparking_citizen/util/state-util.dart';

import 'bill_bloc.dart';

class BillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindSingleton(BillBloc(InjectorWidget.of(context).get()));
      },
      child: MaterialApp(debugShowCheckedModeBanner: false, home: BillContainer()),
    );
  }
}

class BillContainer extends StatefulWidget {
  _BillContainerState createState() => _BillContainerState();
}

class _BillContainerState extends State<BillContainer> {
  final sizeTextCard = 12.0;
  BillBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<BillBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mis Facturas",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          BillInfo info;
          if (state is InitialState) {
            _bloc.dispatch(BillEvent.fetchData);
          }
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SuccessState<BillInfo>) {
            info = state.data;
            if ((info?.bills?.length ?? 0) == 0 && (info?.debts?.length ?? 0) == 0) {
            return  Center(child: Text("No tiene facturas hasta el momento."));
            }
          }

          return info == null
              ? Center(child: Text("No hay informacion disponible"))
              : ListView(
                  children: <Widget>[
                    (info.debts?.length ?? 0) > 0
                        ? Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 20.0, left: 15.0),
                            child: Text(
                              "Pagos Pendientes",
                              style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            ),
                          )
                        : SizedBox(),
                    Column(children: info.debts.map((debt) => buildBillList(debt: debt)).toList()),
                    (info.bills?.length ?? 0) > 0
                        ? Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 20.0, left: 15.0),
                            child: Text(
                              "Facturas",
                              style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            ),
                          )
                        : SizedBox(),
                    Column(children: info.bills.map((bill) => buildBillList(bill: bill)).toList()),
                  ],
                );
        },
      ),
    );
  }

  Widget buildBillList({Debt debt, Bill bill}) {
    if (debt == null && bill == null) {
      return SizedBox();
    }
    bool isPending = debt != null;
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20.0, left: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "\$ ${isPending ? debt.value : bill.value}",
                      style: TextStyle(color: isPending ? Colors.red : Colors.blueAccent, fontSize: sizeTextCard),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 4),
                    isPending
                        ? SizedBox()
                        : Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Icon(Icons.access_time, size: 16.0),
                              ),
                              Text("${bill.createdAt} min", style: TextStyle(fontSize: sizeTextCard)),
                            ],
                          ),
                    SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(AppIcons.vehicle, size: 16.0),
                        ),
                        Text(isPending ? debt.vehiclePlate : bill.vehiclePlate, style: TextStyle(fontSize: sizeTextCard)),
                      ],
                    ),
                  ],
                ),
              ),
              buildDateInfo(isPending ? debt.createdAt : bill.createdAt),
            ],
          ),
        ),
        Divider(height: 20, color: Colors.black26),
      ],
    );
  }

  Widget buildDateInfo(DateTime dateTime) => Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("05/05/2019", style: TextStyle(fontSize: 12.0)),
            Text("10:35pm", style: TextStyle(fontSize: 10.0)),
          ],
        ),
      );
}
