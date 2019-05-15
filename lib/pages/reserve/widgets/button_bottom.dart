import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';

class ButtonBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonBottom =Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 15.0,
            right: 15.0,
            bottom: 10.0
          ),
          child: RaisedButton(
            child: Text('Detener',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            color: Color.fromARGB(0xFF, 0x8B, 0xC3, 0x4A),
            onPressed: _stop,
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)
            )
          ),
          alignment: Alignment.topRight,
        ),
      ],
    );

    return buttonBottom;
  }

  _stop() {

  }
}
