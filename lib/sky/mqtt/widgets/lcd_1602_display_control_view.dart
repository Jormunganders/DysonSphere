import 'package:flutter/material.dart';

/// 控制 LCD1602 显示的操作 View
class LCD1602DisplayControlView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LCD1602DisplayControlState();
}

class _LCD1602DisplayControlState extends State<LCD1602DisplayControlView> {
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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "输入你要显示的文案（只支持英文和数字）",
            ),
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
                  onPressed: () {},
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
