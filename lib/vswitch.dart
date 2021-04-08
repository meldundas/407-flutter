import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:stm32/main.dart';

class Vswitch extends StatefulWidget {
  final int switchNum;

  Vswitch(this.switchNum, {Key key}) : super(key: key);

  @override
  _VswitchState createState() => _VswitchState();
}

class _VswitchState extends State<Vswitch> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;

    return Transform.rotate(
      angle: -3.14 / 2, //-90 degrees
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          print('$isSwitched${widget.switchNum}');
          //port.write(mylist);
          setState(() {
            isSwitched = value;
          });
        },
        activeTrackColor: Colors.red[900],
        activeColor: Colors.red[600],
      ),
    );
  }
}
