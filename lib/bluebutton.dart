import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String button;

  BlueButton(this.button);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.radio_button_on,
          color: Colors.grey[400],
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          '$button',
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
