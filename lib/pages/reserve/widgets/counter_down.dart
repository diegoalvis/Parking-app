import 'package:flutter/material.dart';

class CounterDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterDown = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("00:00",
                    style:
                    TextStyle(
                        color: Colors.black,
                        fontSize: 80.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 10.0,
                    bottom: 15.0
                  ),
                   child: Text("52",
                      style:
                      TextStyle(
                          fontSize: 50.0
                      ),
                    )
                  )
              ],
            ),
            alignment: Alignment.center,
          ),
          Container(
            child: Text("\$ 1.500",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.blue
              ),
            ),
          )
        ],
          crossAxisAlignment: CrossAxisAlignment.center
      ),
    );
    return counterDown;
  }
}
