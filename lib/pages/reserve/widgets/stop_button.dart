import 'package:flutter/material.dart';
import 'package:oneparking_citizen/app_theme.dart';

class StopButton extends StatelessWidget {
  final Function onPressed;
  final String _name;

  const StopButton(this._name, {Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:16.0),
      child: RaisedButton(
        child: Text(_name,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        color: Color.fromARGB(0xFF, 0x8B, 0xC3, 0x4A),
        onPressed: onPressed,
        shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0)
        )
      ),
    );
  }
}
