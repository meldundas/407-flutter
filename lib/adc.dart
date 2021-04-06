import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ADC extends StatefulWidget {
  final int adc0, adc1, adc2;

  ADC(this.adc0, this.adc1, this.adc2);

  @override
  _ADCState createState() => _ADCState();
}

class _ADCState extends State<ADC> {
  double adc0Voltage = 0.0;
  double adc1Voltage = 0.0;
  double adc2Voltage = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      adc0Voltage = widget.adc0 * 3.30 / 4095;
      adc1Voltage = widget.adc1 * 3.30 / 4095;
      adc2Voltage = widget.adc2 * 3.30 / 4095;
    });

    //  print('ADC2: ${widget.adc2} ADC1: ${widget.adc1} ADC0: ${widget.adc0}');

    return Column(children: [
      SizedBox(
        height: 10.0,
      ),
      Row(
        children: [
          Text(
            'ADC2 - ADC0',
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
          Container(
            //  height: 200,
            width: 200,
            child: CircularPercentIndicator(
              radius: 160.0,
              lineWidth: 10.0,
              percent: widget.adc2 / 4095,
              progressColor: Colors.green,
              center: Text(
                "${adc2Voltage.toStringAsFixed(2)} V",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          Container(
            // height: 200,
            width: 200,
            child: CircularPercentIndicator(
              radius: 160.0,
              lineWidth: 10.0,
              percent: widget.adc1 / 4095,
              progressColor: Colors.green,
              center: Text(
                "${adc1Voltage.toStringAsFixed(2)} V",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          Container(
            //height: 200,
            width: 200,
            child: CircularPercentIndicator(
              radius: 160.0,
              lineWidth: 10.0,
              percent: widget.adc0 / 4095,
              progressColor: Colors.green,
              center: Text(
                "${adc0Voltage.toStringAsFixed(2)} V",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        children: [
          Icon(
            Icons.ac_unit,
            color: Colors.grey[400],
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '${widget.adc2}   ${widget.adc1}   ${widget.adc0}',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18.0,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    ]);
  }
}
