import 'package:flutter/material.dart';
import '../add_vehicle/add_vehicle_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/util/widget_util.dart';
import 'package:oneparking_citizen/pages/vehicle/vehicle_bloc.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:oneparking_citizen/pages/vehicle/vehicle_base_event.dart';
import 'package:oneparking_citizen/pages/vehicle/vehicle_state.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';

class VehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindSingleton(VehicleBloc(InjectorWidget.of(context).get()));
      },
      child: VehicleList(),
    );
  }
}

class VehicleList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VehicleListState();
}

class VehicleListState extends State<VehicleList> {
  BuildContext context;
  VehicleBloc _vehicleBloc;
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    onWidgetDidBuild(() {
      _vehicleBloc.dispatch(LoadVehicles());
    });
  }

  @override
  void dispose() {
    _vehicleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _vehicleBloc = InjectorWidget.of(context).get<VehicleBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehiculos", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddVehiclePage()),
            );
          }),
      body: BlocBuilder(
          bloc: _vehicleBloc,
          builder: (context, state) {
            if (state is InitialState) {
              _vehicleBloc.dispatch(LoadVehicles());
              return Container(width: 0.0, height: 0.0);
            }
            if (state is VehiclesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorState) {
              return Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  state.msg,
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              );
            } else if (state is VehiclesLoaded) {
              vehicles = state.vehicles;
              return ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (BuildContext context, int index) {
                  return vehicleDetail(context, index);
                },
              );
            }
          }),
    );
  }

  Widget vehicleDetail(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
          child: GestureDetector(
            child: Row(
              children: <Widget>[
                selectedIcon(context, index),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(vehicles[index].plate, style: Theme.of(context).textTheme.subtitle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(vehicles[index].brand, style: Theme.of(context).textTheme.body2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(vehicles[index].type,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .merge(TextStyle(color: Theme.of(context).primaryColor))),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.clear,
                      color: Colors.black38,
                      size: 20.0,
                    ),
                  ),
                  onTap: () {
                    if (vehicles.length > 1) {
                      _vehicleBloc.dispatch(DeleteVehicle(vehicles[index]));
                    } else {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: Text("Debe existir como minimo un vehiculo"),
                        duration: Duration(milliseconds: 800),
                      ));
                    }
                  },
                ),
              ],
            ),
            onTap: () {
              _vehicleBloc.dispatch(SelectVehicle(vehicles[index]));
            },
          ),
        ),
        Divider(
          height: 15.0,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget selectedIcon(BuildContext context, int index) {
    if (vehicles[index].selected == 1) {
      return Row(
        children: <Widget>[
          Center(
            child: Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 30.0,
            ),
          ),
        ],
      );
    } else {
      return GestureDetector(
          onTap: () {
            _vehicleBloc.dispatch(SelectVehicle(vehicles[index]));
          },
          child: Center(
            child: Opacity(
              opacity: 0.0,
              child: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
            ),
          ));
    }
  }
}
