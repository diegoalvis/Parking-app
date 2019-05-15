import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {

  TitleSection({Key key, this.textTitle}) : super(key: key);

  final String textTitle;
  @override
  Widget build(BuildContext context) {

    final titleSection = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: 15.0,
              bottom: 15.0
          ),
          child: Text(
            this.textTitle,
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

    return titleSection;
  }
}
