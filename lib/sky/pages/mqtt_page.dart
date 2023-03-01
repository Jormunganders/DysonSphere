import 'package:dyson_sphere/sky/mqtt/widgets/lcd_1602_display_control_view.dart';
import 'package:flutter/material.dart';
import 'package:dyson_sphere/sky/mqtt/mqtt_config.dart';
import 'package:dyson_sphere/sky/mqtt/mqtt_factory.dart';

class MQTTPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MQTTState();
}

class _MQTTState extends State<MQTTPage> {
  MQTTManager? mqttManager;

  @override
  void initState() {
    MQTTConfig.waitInitialized(() {
      if (MQTTConfig.isInitialized()) {
        mqttManager = MQTTManager.getInstance(
            MQTTConfig.serverUrl, MQTTConfig.port, "Dyson");
        mqttManager!.connect(MQTTConfig.username, MQTTConfig.password);
      }
    });
    super.initState();
  }

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

  @override
  void dispose() {
    mqttManager?.disconnect();
    super.dispose();
  }
}
