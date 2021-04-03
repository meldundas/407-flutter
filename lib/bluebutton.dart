import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String button;

  BlueButton(this.button);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Button',
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
              width: 75,
              height: 75,
              child: Image(
                image: AssetImage('assets/button$button.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
