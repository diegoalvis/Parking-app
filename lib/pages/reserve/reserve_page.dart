import 'package:flutter/material.dart';
import '../main/main_page.dart';
import 'package:oneparking_citizen/util/app_icons.dart';
import './widgets/description_place.dart';
import './widgets/button_bottom.dart';
import './widgets/counter_down.dart';

void main() => runApp(ReservePage());

class ReservePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: ReserveContainer(),
    );
  }
}

class ReserveContainer extends StatefulWidget {
  _ReserveContainerState createState() => _ReserveContainerState();
}

class _ReserveContainerState extends State<ReserveContainer> {
  @override
  Widget build(BuildContext context) {

    final sizeTextCard = 12.0;

    final thematicBreak = Column(
      children: <Widget>[
        Container(
          height: 1.0,
          color: Colors.black26,
          margin:
          EdgeInsets.symmetric(horizontal: 4.0,
              vertical: 20.0
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Reserva",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Material(
          color: Color.fromRGBO(229, 229, 229, 1),
          child: Column(
            children: <Widget>[
            Container(
              child: CounterDown(),
            ),
            Container(
              color: Colors.white,
              child: DescriptionPlace(icon: Icons.motorcycle, titleDescription: "Placa", content:"ABC 102"),
            ),
            Container(
              color: Colors.white,
              child: Divider(
                height: 15.0,
              ),
            ),
            Container(
              color: Colors.white,
              child: DescriptionPlace(icon: Icons.place, titleDescription: "Nombre de la Zona", content:"Dirección"),
              ),
            Container(
              color: Colors.white,
              child: ButtonBottom(),
            )
            ],
          ),

        ),
    );

  }
}
