import 'package:flutter/material.dart';

class Checksum extends StatefulWidget {
  final int checksumFromSerial, checksumValue, checksumErrors;

  Checksum(this.checksumFromSerial, this.checksumValue, this.checksumErrors);

  @override
  _ChecksumState createState() => _ChecksumState();
}

class _ChecksumState extends State<Checksum> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Checksum',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.radio_button_on,
              color: Colors.grey[400],
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '${widget.checksumValue}',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 18.0,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Errors: ${widget.checksumErrors}',
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
