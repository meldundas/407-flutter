import 'dart:ui';

import 'package:flutter/material.dart';

class Packet extends StatelessWidget {
  final String mys;

  Packet(this.mys);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'PACKET',
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
        Row(
          children: [
            Text(
              mys,
              style: TextStyle(
                fontFeatures: [
                  FontFeature.tabularFigures()
                ], //tabular font spacing
                color: Colors.amberAccent[200],
                letterSpacing: 1.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
