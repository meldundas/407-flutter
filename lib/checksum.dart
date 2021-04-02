import 'package:flutter/material.dart';

class Checksum extends StatefulWidget {
  @override
  _ChecksumState createState() => _ChecksumState();
}

class _ChecksumState extends State<Checksum> {
  String checksum = '0';
  int checksumErrors = 0;

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
          '$checksum',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 18.0,
            letterSpacing: 1.0,
          ),
        ),
        Text('Errors: $checksumErrors'),
      ],
    );
  }
}
