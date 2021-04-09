import 'package:flutter/material.dart';

@override
class Vswitch extends StatelessWidget {
  Vswitch({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final ValueChanged<bool> onChanged;
  final bool active;

  void handleButton(bool) {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -3.14 / 2, //-90 degrees
      child: Switch(
        value: active,
        onChanged: handleButton,
        activeTrackColor: Colors.red[900],
        activeColor: Colors.red[600],
      ),
    );
  }
}
