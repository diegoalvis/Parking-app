import 'package:flutter/material.dart';

class DescriptionPlace extends StatelessWidget {

  DescriptionPlace({Key key, this.icon, this.titleDescription, this.content}) : super(key: key);

  final IconData icon;
  final String titleDescription;
  final String content;

  @override
  Widget build(BuildContext context) {
    final description = Container(
      margin: EdgeInsets.only(
        top: 15.0,
        left: 15.0
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: 15.0
            ),
            child: Icon(
                this.icon
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    this.titleDescription,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      fontSize: 12.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 5.0
                  ),
                  child: Text(
                    this.content,
                    style: TextStyle(
                      fontSize: 12.0
                    ),
                  ),
                )
              ],
            ),
            alignment: Alignment.centerLeft,
          )
        ],
      ),
      alignment: Alignment.topRight,
    );

    return description;
  }
}
