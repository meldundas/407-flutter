import 'package:flutter/material.dart';

class Packet extends StatelessWidget {
  final String mys;

  Packet(this.mys);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'PACKET',
          style: TextStyle(
            color: Colors.grey,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          mys,
          style: TextStyle(
            color: Colors.amberAccent[200],
            letterSpacing: 2.0,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
