import 'package:flutter/material.dart';

class DigitalIn extends StatelessWidget {
  final String in7, in6, in5, in4, in3, in2, in1, in0;

  DigitalIn(this.in7, this.in6, this.in5, this.in4, this.in3, this.in2,
      this.in1, this.in0);
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
          '$in7$in6$in5$in4$in3$in2$in1$in0',
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
