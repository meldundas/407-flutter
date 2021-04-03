import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';

class ADC extends StatelessWidget {
  final int adc0, adc1, adc2;

  ADC(this.adc0, this.adc1, this.adc2);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                height: 220,
                width: 220,
                color: Colors.grey[900], //Colors.black38,
                child: FlutterGauge(
                  inactiveColor: Colors.white38,
                  activeColor: Colors.white,
                  handSize: 30,
                  width: 200,
                  index: adc0 * 330 / 4095,
                  fontFamily: "Iran",
                  end: 330,
                  number: Number.none,
                  secondsMarker: SecondsMarker.minutes,
                  isCircle: false,
                  hand: Hand.none,
                  counterAlign: CounterAlign.center,
                  counterStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  isDecimal: false,
                )),
            Container(
                height: 220,
                width: 220,
                color: Colors.grey[900], //Colors.black38,
                child: FlutterGauge(
                  inactiveColor: Colors.white38,
                  activeColor: Colors.white,
                  handSize: 30,
                  width: 200,
                  index: adc1 * 330 / 4095,
                  fontFamily: "Iran",
                  end: 330,
                  number: Number.none,
                  secondsMarker: SecondsMarker.minutes,
                  isCircle: false,
                  hand: Hand.none,
                  counterAlign: CounterAlign.center,
                  counterStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  isDecimal: false,
                )),
            Container(
                height: 220,
                width: 220,
                color: Colors.grey[900], //Colors.black38,
                child: FlutterGauge(
                  inactiveColor: Colors.white38,
                  activeColor: Colors.white,
                  handSize: 30,
                  width: 200,
                  index: adc2 * 330 / 4095,
                  fontFamily: "Iran",
                  end: 330,
                  number: Number.none,
                  secondsMarker: SecondsMarker.minutes,
                  isCircle: false,
                  hand: Hand.none,
                  counterAlign: CounterAlign.center,
                  counterStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  isDecimal: false,
                )),
          ],
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
              '$adc0   $adc1   $adc2',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 18.0,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
