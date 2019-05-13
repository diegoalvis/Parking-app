import 'package:flutter/material.dart';
import './widgets/title_section.dart';
import './widgets/day_hour_column.dart';
import './widgets/table_prices.dart';
import '../main/main_page.dart';

void main() => runApp(InfoPage());

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfoContainer()
    );
  }
}

class InfoContainer extends StatefulWidget{
  _InfoContainerState createState() =>  _InfoContainerState();
}

class _InfoContainerState extends State<InfoContainer>{
  @override
  Widget build(BuildContext context) {

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

    final descriptionText = "Los precios por el uso de espacio publico se establecieron por Concejo de Sabaneta en el estatuto tributario 041 del 2018";
    final descriptionBottomPriceText = "Tiempo base de parqueo es 60 min y cada fracción adicional es de 15 min.";

    final descriptionSection = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 15.0,
            left: 25.0,
            right: 25.0
          ),
          child: Text(descriptionText,
          style: TextStyle(
            fontSize: 14.0
            ),
          textAlign: TextAlign.center,
          ),
        ),
      ],
    );


    final descriptionBottomPrice = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: 20.0,
              left: 15.0
          ),
          child: Text(
            descriptionBottomPriceText,
            style: TextStyle(
                fontSize: 13.0,
                color: Colors.black54,
                fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.left,
          ),
          alignment: Alignment.centerLeft,
        ),
      ],
    );

      final priceSection = Column(
        children: <Widget>[
          Container(
            child: TitleSection(textTitle:"Precios"),
          ),
          Container(
            child: TablePrices(baseCar: "1.500", fractionCar: "700", baseMoto: "1.200", fractionMoto: "400",),
          ),
          Container(
            child: descriptionBottomPrice,
          )
        ],
      );

      final comercialAreaSection = Column(
        children: <Widget>[
          Container(
            child:  TitleSection(textTitle:"Zonas Comerciales"),
          ),
          Container(
            child: DayHourColumn(days: "Lunes a Jueves", hours: "8:00 am a 10:00 pm"),
          ),
          Container(
            child: DayHourColumn(days: "Viernes a Sábado", hours: "8:00 am a 11:00 pm"),
          ),
          Container(
            child: DayHourColumn(days: "Domingo", hours: "No especificado"),
          )
        ],
      );

      final residencialSection = Column(
        children: <Widget>[
          Container(
            child: TitleSection(textTitle:"Zonas Comerciales"),
          ),
          Container(
            child: DayHourColumn(days: "Lunes a Sábado", hours: "8:00 am a 10:00 pm"),
          ),
          Container(
            child: DayHourColumn(days: "Domingo", hours: "No especificado"),
          )
        ],
      );



      return Scaffold(
          appBar: AppBar(
            title: Text("Información",
              style: TextStyle(
                  color: Colors.black
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: <Widget>[
                  Container(
                      child: descriptionSection
                  ),
                  Container(
                    child: thematicBreak,
                  ),
                  Container(
                      child: priceSection
                  ),
                  Container(
                      child: thematicBreak
                  ),
                  Container(
                      child: comercialAreaSection
                  ),
                  Container(
                      child: thematicBreak
                  ),
                  Container(
                      child: residencialSection
                  )
                ],
              ),
            ),
          )
      );
    }
  }


