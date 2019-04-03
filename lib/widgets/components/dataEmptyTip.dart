import 'package:flutter/material.dart';

class DataEmptyTip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.warning,
              color: Colors.redAccent,
            ),
            Text('  There is no Data.')
          ],
        ),
      ),
    );
  }
}
