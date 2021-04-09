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
  bool isSwitched = false;
  int checksumValue = 0;

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
    checksumValue = 0;
    for (int loop = 3; loop < 15; loop++) {
      checksumValue += data.codeUnitAt(loop);
      checksumValue %= 1000;
    }

    setState(() {
      data = data +
          checksumValue.toString().padLeft(3, '0'); //leading zeros in checksum
    });

    List<int> mylist = data.codeUnits; //string to List<int>

    Uint8List sendPacket = Uint8List.fromList(mylist); //List<int> to Uint8List

    port.write(sendPacket);

    //print(data);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              "Digital Outputs",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Vswitch(
                    active: out7 == '1',
                    onChanged: (isSwitched) {
                      setState(() {
                        out7 = isSwitched == true ? '1' : '0';
                      });
                    }),
                Vswitch(
                    active: out6 == '1',
                    onChanged: (isSwitched) {
                      setState(() {
                        out6 = isSwitched == true ? '1' : '0';
                      });
                    }),
                Vswitch(
                    active: out5 == '1',
                    onChanged: (isSwitched) {
                      setState(() {
                        out5 = isSwitched == true ? '1' : '0';
                      });
                    }),
                Vswitch(
                    active: out4 == '1',
                    onChanged: (isSwitched) {
                      setState(() {
                        out4 = isSwitched == true ? '1' : '0';
                      });
                    }),
                SizedBox(
                  width: 20,
                ),
                Vswitch(
                    active: out3 == '1',
                    onChanged: (isSwitched) {
                      setState(() {
                        out3 = isSwitched == true ? '1' : '0';
                      });
                    }),
                Vswitch(
                    active: out2 == '1',
                    onChanged: (isSwitched) {
                      setState(() {
                        out2 = isSwitched == true ? '1' : '0';
                      });
                    }),
                Vswitch(
                    active: out1 == '1',
                    onChanged: (isSwitched) {
                      setState(() {
                        out1 = isSwitched == true ? '1' : '0';
                      });
                    }),
                Vswitch(
                    active: out0 == '1',
                    onChanged: (isSwitched) {
                      setState(() {
                        out0 = isSwitched == true ? '1' : '0';
                      });
                    }),
              ],
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
            SizedBox(
              height: 10,
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
