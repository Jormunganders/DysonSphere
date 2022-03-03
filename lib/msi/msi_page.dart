import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';

class MSIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MSIState();
}

class _MSIState extends State<MSIPage> {
  String _message = "";
  LCObject msi = LCObject("MSI");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "信息",
                            ),
                            textInputAction: TextInputAction.send,
                            maxLines: 4,
                            minLines: 1,
                            maxLength: 999,
                            onChanged: (text) {
                              _message = text;
                            },
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: sendMessage, child: const Text("发送")),
                    ]))),
            Center(
              child: Text("其他消息!"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    msi['message'] = _message;
    await msi.save();
    // todo
  }
}
