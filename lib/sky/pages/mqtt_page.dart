import 'package:dyson_spherec_calculator/sky/mqtt/widgets/lcd_1602_display_control_view.dart';
import 'package:flutter/material.dart';

class MQTTPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          margin: const EdgeInsets.only(top: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: LCD1602DisplayControlView(),
          ),
        )
      ],
    );
  }
}
