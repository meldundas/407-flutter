import 'package:flutter/material.dart';

class PacketCount extends StatelessWidget {
  final String count;

  PacketCount(this.count);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Count',
          style: TextStyle(
            color: Colors.grey,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          count,
          style: TextStyle(
            color: Colors.amberAccent[200],
            letterSpacing: 2.0,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30.0,
        )
      ],
    );
  }
}
