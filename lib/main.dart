import 'package:dart_serial_port/dart_serial_port.dart';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_gauge/flutter_gauge.dart';

import 'package:stm32/packet.dart';
import 'package:stm32/packetcount.dart';
import 'package:stm32/accelerometer.dart';
import 'package:stm32/adc.dart';
import 'package:stm32/digitalin.dart';
import 'package:stm32/bluebutton.dart';
import 'package:stm32/checksum.dart';

String s = '';
var name;
var port;
int main() {
  name = SerialPort.availablePorts.first;
  port = SerialPort(name);
  if (!port.openReadWrite()) {
    print(SerialPort.lastError);
    exit(-1);
  } else {
    print(name);
  }

  runApp(MaterialApp(
    home: MyApp(),
  ));

  // getData();
  print('done');
  return 0;
}

//port.write(/* ... */);
Future<String> getData() async {
  final reader = SerialPortReader(port);
  reader.stream.listen((data) {
    s = String.fromCharCodes(data);
    print(s);
  });
  return 'nogo';
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //###
  //count
  //%03d (uint16_t)count
  //accelerometer
  //%04X%04X%04X (uint16_t)XYZ[0], (uint16_t)XYZ[1], (uint16_t)XYZ[2]);
  //3 ADCs
  //"%04d%04d%04d", (uint16_t)adcValues[0],(uint16_t)adcValues[1],(uint16_t)adcValues[2]);
  //8 digital inputs
  // sprintf(packet + 30, "%0d", inputPort[7]); //strlen(myData)
  // sprintf(packet + 31, "%0d", inputPort[6]);
  // sprintf(packet + 32, "%0d", inputPort[5]);
  // sprintf(packet + 33, "%0d", inputPort[4]);
  // sprintf(packet + 34, "%0d", inputPort[3]);
  // sprintf(packet + 35, "%0d", inputPort[2]);
  // sprintf(packet + 36, "%0d", inputPort[1]);
  // sprintf(packet + 37, "%0d", inputPort[0]);

  // //Blue Button
  // sprintf(packet + 38, "%0d", HAL_GPIO_ReadPin(B1_GPIO_Port,  B1_Pin));

  // //calculate checksum
  // for(int loop=3; loop<=strlen(packet); loop++)
  // {
  //   checksum += packet[loop];
  // }
  // checksum %=1000;	//3 digits
  // sprintf(packet + 39, "%03d\r\n", checksum);

  String mys = '';

  String startOfFrame;

  String count;

  String accX;
  String accY;
  String accZ;

  String adc0;
  String adc1;
  String adc2;

  String in7;
  String in6;
  String in5;
  String in4;
  String in3;
  String in2;
  String in1;
  String in0;

  String button;

  String checksum;

  int checksumValue = 0;

  int checksumErrors = 0;

  @override
  void initState() {
    super.initState();

    final reader = SerialPortReader(port);
    reader.stream.listen((data) {
      mys = String.fromCharCodes(data);

      //checksum in string
      checksum = mys.substring(39, 42);
      int checksumFromSerial = int.parse(checksum);

      //calculate what checksum is from received data
      checksumValue = 0;
      for (int loop = 3; loop < 39; loop++) {
        checksumValue += mys.codeUnitAt(loop);
        checksumValue %= 1000;
      }

      //print both
      print('$checksumFromSerial  $checksumValue');

      if (checksumFromSerial == checksumValue) {
        setState(() {
          startOfFrame = mys.substring(0, 3);

          count = mys.substring(3, 6);

          accX = mys.substring(6, 10);
          accY = mys.substring(10, 14);
          accZ = mys.substring(14, 18);

          adc0 = mys.substring(18, 22);
          adc1 = mys.substring(22, 26);
          adc2 = mys.substring(26, 30);

          in7 = mys.substring(30, 31);
          in6 = mys.substring(31, 32);
          in5 = mys.substring(32, 33);
          in4 = mys.substring(33, 34);
          in3 = mys.substring(34, 35);
          in2 = mys.substring(35, 36);
          in1 = mys.substring(36, 37);
          in0 = mys.substring(37, 38);

          button = mys.substring(38, 39);
        });
      } else {
        checksumErrors++;
      }
      // print(mys);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('STM32F407'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/STM32F407G-DISC1.webp'),
                  radius: 50.0,
                ),
              ),
              Divider(
                height: 60.0,
                color: Colors.grey[800],
              ),
              Packet(mys),
              PacketCount(count),
              Accelerometer(accX, accY, accZ),
              ADC(adc0, adc1, adc2),
              DigitalIn(in7, in6, in5, in4, in3, in2, in1, in0),
              BlueButton(button),
              Checksum(),
            ],
          ),
        ),
      ),
    );
  }
}
