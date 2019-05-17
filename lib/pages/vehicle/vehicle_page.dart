import 'package:flutter/material.dart';
import '../add_vehicle/add_vehicle_page.dart';

class VehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: new Text(
                  "Desliza hacia abajo para recargar los vehiculos",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              new VehicleDetail("ABC 123", "Mazda", "Carro"),
              new VehicleDetail("ABC 123", "Mazda", "Carro"),
            ],
          ),
        ),
      ),
    );
  }
}

class VehicleDetail extends StatelessWidget {
  final String licensePlate;
  final String tradeMark;
  final String type;

  VehicleDetail(this.licensePlate, this.tradeMark, this.type);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
          child: Row(
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(this.licensePlate, style: Theme.of(context).textTheme.subtitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(this.tradeMark, style: Theme.of(context).textTheme.body2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(this.type,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .merge(TextStyle(color: Theme.of(context).primaryColor))),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.clear,
                  color: Colors.black38,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 15.0,
          color: Colors.grey,
        ),
      ],
    );
  }
}
