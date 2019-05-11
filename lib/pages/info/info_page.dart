import 'package:flutter/material.dart';
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

    final descriptionText = Column(
      children: <Widget>[
        Container(
          child: Text("Descripción del texto"),
        ),
      ],
    );

    final priceSection = Column(
      children: <Widget>[
        Container(
          child: Text("Sección de precios"),
        ),
      ],
    );

    final comercialAreaSection = Column(
      children: <Widget>[
        Container(
          child: Text("Sección de Zonas comerciales"),
        ),
      ],
    );

    final residencialSection = Column(
      children: <Widget>[
        Container(
          child: Text("Sección de Zonas Residenciales"),
        ),
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
        body: new Container(
          color: Theme.of(context).canvasColor,
          child: Column(
            children: <Widget>[
              Container(
                  child: descriptionText
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
              ),
            ],
          ),
        )
    );
  }

}
