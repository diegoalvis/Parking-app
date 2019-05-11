import 'package:flutter/material.dart';
import '../main/main_page.dart';
import 'package:oneparking_citizen/util/app_icons.dart';

void main() => runApp(BillPage());

class BillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: BillContainer(),
    );
  }
}

class BillContainer extends StatefulWidget {
  _BillContainerState createState() => _BillContainerState();
}

class _BillContainerState extends State<BillContainer> {
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

    final pagosPendientes = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 20.0,
            left: 15.0
          ),
          child: Text(
            "Pagos Pendientes",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
              fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.left,
          ),
          alignment: Alignment.centerLeft,
        ),
        Container(
          margin: EdgeInsets.only(
            top: 20.0,
            left: 15.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 10.0
                ),

                child: new Align(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 0.0
                        ),
                        child: Text(
                          "\$ 500",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: sizeTextCard
                          ),
                          textAlign: TextAlign.left,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 10.0
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                right: 15.0
                              ),
                              child: Icon(
                                  AppIcons.vehicle,
                                size: 16.0,
                              ),
                            ),
                            Container(
                              child: Text("ABC 123",
                              style: TextStyle(
                                fontSize: sizeTextCard
                                ),
                              ),
                            ),
                          ],  
                        ),
                      ),
                    ],
                      crossAxisAlignment: CrossAxisAlignment.start
                  ),
                  alignment: Alignment.topLeft,
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                margin: EdgeInsets.only(
                    right: 25.0
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                          "05/05/2019",
                        style: TextStyle(
                          fontSize: 12.0
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                          "10:35pm",
                        style: TextStyle(
                          fontSize: 10.0
                        ),
                      ),
                    ),

                  ],
                    crossAxisAlignment: CrossAxisAlignment.end
                ),
                alignment: Alignment.topRight,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      ],
    );

    final facturasTitle = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: 20.0,
              left: 15.0,
            bottom: 10.0
          ),
          child: Text(
            "Facturas",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
                fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.left,
          ),
          alignment: Alignment.centerLeft,
        ),
      ],
    );


    final facturas = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: 15.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 10.0
                ),

                child: new Align(
                  child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: 0.0
                          ),
                          child: Text(
                            "\$ 500",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: sizeTextCard
                            ),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5.0
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: 15.0
                                ),
                                child: Icon(
                                    Icons.access_time,
                                  size: 16.0,
                                ),
                              ),
                              Container(
                                child: Text("35 min",
                                style: TextStyle(
                                  fontSize: sizeTextCard
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5.0
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: 15.0
                                ),
                                child: Icon(
                                    AppIcons.vehicle,
                                  size: 16.0,
                                ),
                              ),
                              Container(
                                child: Text("ABC 123",
                                style: TextStyle(
                                  fontSize: sizeTextCard
                                ),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start
                  ),
                  alignment: Alignment.topLeft,
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                margin: EdgeInsets.only(
                    right: 25.0
                ),
                child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "05/05/2019",
                          style: TextStyle(
                              fontSize: 12.0
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "10:35pm",
                          style: TextStyle(
                              fontSize: 10.0
                          ),
                        ),
                      ),

                    ],
                    crossAxisAlignment: CrossAxisAlignment.end
                ),
                alignment: Alignment.topRight,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Facturas",
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
                child: pagosPendientes
            ),
            Container(
              child: facturasTitle,
            ),
            Container(
                child: facturas
            ),
            Container(
                child: thematicBreak
            ),
            Container(
                child: facturas
            ),
            Container(
                child: thematicBreak
            ),
            Container(
                child: facturas
            ),
          ],
        ),
      )
      );

  }
}
