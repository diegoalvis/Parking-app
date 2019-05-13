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
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new Icon(
                          AppIcons.vehicle,
                          size: 16.0,
                          color: Colors.transparent,
                        ),
                        new Text("Base"),
                        new Text("Fracción"),
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
                      new Text(this.baseCar,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      new Text(this.fractionCar),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Icon(
                        Icons.motorcycle,
                        size: 16.0,
                      ),
                      new Text(this.baseMoto),
                      new Text(this.fractionMoto),
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
