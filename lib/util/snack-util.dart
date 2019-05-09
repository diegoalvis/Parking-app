import 'package:flutter/material.dart';

void showSnack(BuildContext context, String msg){
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ),
  );
}
