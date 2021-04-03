import 'package:flutter/material.dart';
//import 'package:flutter_3d_obj/flutter_3d_obj.dart';

import 'dart:math' as math;

class Accelerometer extends StatelessWidget {
  final int accX, accY, accZ;

  Accelerometer(this.accX, this.accY, this.accZ);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Transform.rotate(
            angle: accX * math.pi / 180, //angle in radians
            child: Icon(
              Icons.airplanemode_on,
              color: Colors.red,
              size: 100,
            ),
          ),
        ]),
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
