import 'package:flutter/material.dart';
import 'package:oneparking_citizen/util/app_icons.dart';

class TablePrices extends StatelessWidget {

  TablePrices({Key key, this.baseCar, this.fractionCar, this.baseMoto, this.fractionMoto}) : super(key: key);

  final String baseCar;
  final String fractionCar;
  final String baseMoto;
  final String fractionMoto;

  @override
  Widget build(BuildContext context) {

    final table = Table(
      children: [
        TableRow(
          children: [
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new Icon(
                          AppIcons.vehicle,
                          size: 16.0,
                          color: Colors.transparent,
                        ),
                        new Text("Base",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                        ),
                        new Text("Fracción",
                        style: TextStyle(
                          color: Colors.grey
                          ),
                        textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Icon(
                        AppIcons.vehicle,
                        size: 16.0,
                      ),
                      Container(
                        child: new Text(this.baseCar,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).accentColor,

                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),

                      new Text(this.fractionCar,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Icon(
                        Icons.motorcycle,
                        size: 16.0,
                      ),
                      new Text(this.baseMoto,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      new Text(this.fractionMoto,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),

            )
          ]
        )
      ],
    );

    return table;
  }
}
