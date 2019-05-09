import 'package:flutter/material.dart';
import '../main/main_page.dart';

void main() => runApp(VehiclePage());

class VehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          new DrawerOnly(),
          new Expanded(
            child: Column(
              children: <Widget>[
                new AppBar(
                  title: Text("Vehiculos",
                      style: TextStyle(fontSize: 22, color: Colors.grey, fontWeight: FontWeight.w400)),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: new Text(
                    "Desliza hacia abajo para recargar los vehiculos",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                new VehicleDetail("ABC 123", "Mazda", "Carro"),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new FloatingActionButton(
                          backgroundColor: Color.fromARGB(0xFF, 0x8B, 0xC3, 0x4A),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: null),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
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
                  color: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
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
                              .merge(TextStyle(color: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2)))),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Icon(
                    Icons.clear,
                    color: Colors.grey,
                    size: 20.0,
                  ),
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
