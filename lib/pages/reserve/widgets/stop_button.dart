import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';

class StopButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonBottom = RaisedButton(
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
    );

    return buttonBottom;
  }

  _stop() {

  }
}
