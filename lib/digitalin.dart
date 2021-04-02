import 'package:flutter/material.dart';

class DigitalIn extends StatelessWidget {
  final String in7, in6, in5, in4, in3, in2, in1, in0;

  DigitalIn(this.in7, this.in6, this.in5, this.in4, this.in3, this.in2,
      this.in1, this.in0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              'Digital Inputs',
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
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage('assets/red-led-$in7.png'),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage('assets/red-led-$in6.png'),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage('assets/red-led-$in5.png'),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage('assets/red-led-$in4.png'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage('assets/red-led-$in3.png'),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage('assets/red-led-$in2.png'),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage('assets/red-led-$in1.png'),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage('assets/red-led-$in0.png'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
