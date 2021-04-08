/// ###
/// out7 -out0
/// blue led
/// red led
/// orange led
/// green led
/// checksum xxx calculated from 3-14
/// //checksum 576-588 with onboard LEDs, 00000000xxxx = 576-580

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stm32/main.dart';
import 'package:stm32/vswitch.dart';

class Upload extends StatefulWidget {
  //final port;

  //Upload(this.port);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  bool isSwitched;
  String out7 = '0';
  String out6 = '0';
  String out5 = '0';
  String out4 = '0';
  String out3 = '0';
  String out2 = '0';
  String out1 = '0';
  String out0 = '0';

  String blue = '0';
  String red = '0';
  String yellow = '0';
  String green = '0';

  @override
  Widget build(BuildContext context) {
    String data = '###' +
        out7 +
        out6 +
        out5 +
        out4 +
        out3 +
        out2 +
        out1 +
        out0 +
        blue +
        red +
        yellow +
        green;

    //calculate what checksum for sent data
    int checksumValue = 0;
    for (int loop = 3; loop < 15; loop++) {
      checksumValue += data.codeUnitAt(loop);
      checksumValue %= 1000;
    }

    setState(() {
      data = data + checksumValue.toString();
    });

    List<int> mylist = data.codeUnits; //string to List<int>

    Uint8List sendPacket = Uint8List.fromList(mylist); //List<int> to Uint8List

    port.write(sendPacket);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Vswitch(7),
                Vswitch(6),
                Vswitch(5),
                Vswitch(4),
                SizedBox(
                  width: 20,
                ),
                Vswitch(3),
                Vswitch(2),
                Vswitch(1),
                Vswitch(0),
                Transform.rotate(
                  angle: -3.14 / 2, //-90 degrees
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      print('$isSwitched');
                      setState(() {
                        isSwitched = value;
                        if (isSwitched)
                          out0 = '1';
                        else
                          out0 = '0';
                      });
                    },
                    activeTrackColor: Colors.red[900],
                    activeColor: Colors.red[600],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Packet to Send",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data,
              style: TextStyle(
                fontFeatures: [
                  FontFeature.tabularFigures(),
                ], //tabular font spacing
                color: Colors.amberAccent[200],
                letterSpacing: 1.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Onboard LEDs",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/blue$blue.png'),
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      blue == '1' ? blue = '0' : blue = '1';
                    });
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/red-led-$red.png'),
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      red == '1' ? red = '0' : red = '1';
                    });
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/yellow$yellow.png'),
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      yellow == '1' ? yellow = '0' : yellow = '1';
                    });
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/green$green.png'),
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      green == '1' ? green = '0' : green = '1';
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
