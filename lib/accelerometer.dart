import 'package:flutter/material.dart';
//import 'package:flutter_3d_obj/flutter_3d_obj.dart';

import 'dart:math' as math;

class Accelerometer extends StatelessWidget {
  //accx - +/- 2g setting
  //0.06 mg per bit
  static double deviation = 0.06;

  final int accX, accY, accZ;

  Accelerometer(this.accX, this.accY, this.accZ);

  @override
  Widget build(BuildContext context) {
    Color myColor = Colors.red;

    double aX = accX * deviation;
    double aY = accY * deviation;
    double aZ = accZ * deviation;

    //if upside down go red
    if (aZ < 0) {
      myColor = Colors.red;
    } else {
      myColor = Colors.blue;
    }

    //pitch and roll - miniusb on the left micro usb on the right
    double pitch = math.atan(aX / math.sqrt(math.pow(aY, 2) + math.pow(aZ, 2)));
    double roll = math.atan(aY / math.sqrt(math.pow(aX, 2) + math.pow(aZ, 2)));

    //print('Pitch: $pitch  Roll: $roll');

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                'Accelerometer',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Transform(
            transform: Matrix4(
              1,
              0,
              0,
              0,
              0,
              1,
              0,
              0,
              0,
              0,
              1,
              0,
              0,
              0,
              0,
              1,
            )
              ..rotateY(roll) //rotate in radians
              ..rotateX(pitch)
              ..scale(aZ / 100),
            alignment: FractionalOffset.center,
            child: Icon(
              Icons.airplanemode_on,
              color: myColor,
              size: 100,
            ),
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
      ),
    );
  }
}
