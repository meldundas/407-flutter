import 'package:flutter/material.dart';

class ADC extends StatelessWidget {
  final String adc0, adc1, adc2;

  ADC(this.adc0, this.adc1, this.adc2);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.ac_unit,
          color: Colors.grey[400],
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          '$adc0   $adc1   $adc2',
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
