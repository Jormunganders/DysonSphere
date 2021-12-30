import 'dart:async';

import 'package:dyson_spherec_calculator/base/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 只是一个单纯显示时间的页面
class TimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  late Timer _timer;
  var _duration = Duration(seconds: 1);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer = Timer.periodic(_duration, (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          TimeUtils.parseDateTime(DateTime.now()),
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 30.0,
            fontWeight: FontWeight.w100,
            background: new Paint()..color = Colors.yellow,
          ),
        ),
      ),
      color: Colors.white,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
