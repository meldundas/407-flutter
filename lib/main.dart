import 'package:dart_serial_port/dart_serial_port.dart';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_gauge/flutter_gauge.dart';
//import 'package:moving_average/moving_average.dart';

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
    debugShowCheckedModeBanner: false,
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

  String accX = '0';
  String accY = '0';
  String accZ = '0';

  String adc0 = '0';
  String adc1 = '0';
  String adc2 = '0';

  String in7 = '0';
  String in6 = '0';
  String in5 = '0';
  String in4 = '0';
  String in3 = '0';
  String in2 = '0';
  String in1 = '0';
  String in0 = '0';

  String button = '0';

  String checksum = '0';
  int checksumFromSerial = 0;

  int checksumValue = 0;

  static int checksumErrors = 0;

  static int window = 32; //number of samples to average
  //acceleromter averaging
  int accCount = 0;

  int accXAverage = 0;
  var accXList = List.filled(window, 0);

  int accYAverage = 0;
  var accYList = List.filled(window, 0);

  int accZAverage = 0;
  var accZList = List.filled(window, 0);

  //adc averaging
  int adcCount = 0;

  int adc0Average = 0;
  var adc0List = List.filled(window, 0);

  int adc1Average = 0;
  var adc1List = List.filled(window, 0);

  int adc2Average = 0;
  var adc2List = List.filled(window, 0);

  @override
  void initState() {
    super.initState();

    final reader = SerialPortReader(port);
    reader.stream.listen((data) {
      mys = String.fromCharCodes(data);

      //checksum in string
      checksum = mys.substring(39, 42);
      checksumFromSerial = int.parse(checksum);

      //calculate what checksum is from received data
      checksumValue = 0;
      for (int loop = 3; loop < 39; loop++) {
        checksumValue += mys.codeUnitAt(loop);
        checksumValue %= 1000;
      }

      //print both
      //print('$checksumFromSerial  $checksumValue');

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
    //convert acc hex strings to signed decimal numbers
    int decX = int.parse(accX, radix: 16);
    if (decX > 32768) decX = decX - 65536;

    int decY = int.parse(accY, radix: 16);
    if (decY > 32768) decY = decY - 65536;

    int decZ = int.parse(accZ, radix: 16);
    if (decZ > 32768) decZ = decZ - 65536;

    //fill acc lists
    accXList[adcCount] = decX;
    accYList[adcCount] = decY;
    accZList[adcCount] = decZ;

    accCount++;
    accCount %= window;

    accXList.forEach((e) => accXAverage += e);
    accXAverage = accXAverage ~/ window;

    accYList.forEach((e) => accYAverage += e);
    accYAverage = accYAverage ~/ window;

    accZList.forEach((e) => accZAverage += e);
    accZAverage = accZAverage ~/ window;

    //fill adc lists
    adc0List[adcCount] = int.parse(adc0);
    adc1List[adcCount] = int.parse(adc1);
    adc2List[adcCount] = int.parse(adc2);
    //print(adc0List);
    // print(adc1List);
    // print(adc2List);
    adcCount++;
    adcCount %= window;

    adc0Average = 0; //clear previous values
    adc0List.forEach((e) => adc0Average += e);
    adc0Average = adc0Average ~/ window;
    //print(adc0Average);

    adc1Average = 0;
    adc1List.forEach((e) => adc1Average += e);
    adc1Average = adc1Average ~/ window;

    adc2Average = 0;
    adc2List.forEach((e) => adc2Average += e);
    adc2Average = adc2Average ~/ window;

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
              Row(
                children: [
                  PacketCount(count),
                  SizedBox(
                    width: 30,
                  ),
                  Checksum(checksumFromSerial, checksumValue, checksumErrors),
                ],
              ),
              Accelerometer(accXAverage, accYAverage, accZAverage),
              ADC(adc0Average, adc1Average, adc2Average),
              Row(
                children: [
                  DigitalIn(in7, in6, in5, in4, in3, in2, in1, in0),
                  SizedBox(
                    width: 30,
                  ),
                  BlueButton(button),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
