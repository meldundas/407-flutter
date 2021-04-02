import 'package:flutter/material.dart';

class Accelerometer extends StatelessWidget {
  final String accX, accY, accZ;

  Accelerometer(this.accX, this.accY, this.accZ);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.airplanemode_on,
          color: Colors.grey[400],
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          '$accX   $accY   $accZ',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 18.0,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
