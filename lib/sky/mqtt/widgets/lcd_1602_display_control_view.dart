import 'dart:convert';

import 'package:dyson_sphere/sky/mqtt/mqtt_factory.dart';
import 'package:flutter/material.dart';

import '../model/mqtt_models.dart';
import '../mqtt_constans.dart';

/// 控制 LCD1602 显示的操作 View
class LCD1602DisplayControlView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LCD1602DisplayControlState();
}

class _LCD1602DisplayControlState extends State<LCD1602DisplayControlView> {
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.center,
              child: Padding(
                child: Text(
                  "LCD 1602",
                  style: TextStyle(
                    fontSize: 32.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: const EdgeInsets.only(
                  bottom: 12,
                  top: 12,
                ),
              )),
          TextField(
            controller: _controller = TextEditingController(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "输入你要显示的文案（只支持英文和数字）",
            ),
            // todo ascii 码限制汉字
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    SnackBar snackBar;
                    if (MQTTManager.tryGetInstance()?.isConnected() == true) {
                      MQTTManager.tryGetInstance()?.publishMessage(
                          LCD1602_UPDATE_MESSAGE,
                          jsonEncode(LCD1602Message(_controller.text)));
                      snackBar = SnackBar(
                        content: const Text('显示成功！'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      );
                      setState(() {
                        _controller.clear();
                      });
                    } else {
                      snackBar = SnackBar(
                        content: const Text(
                          '显示失败，服务不可用！',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text("显示"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
