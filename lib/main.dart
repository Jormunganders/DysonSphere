import 'dart:ui';

import 'package:dyson_sphere/base/lean_cloud_config.dart';
import 'package:dyson_sphere/sky/mqtt/mqtt_config.dart';
import 'package:flutter/material.dart';
import 'package:dyson_sphere/base/values.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leancloud_storage/leancloud.dart';

import 'base/pages/dyson_page.dart';

void main() {
  config();
  // var width = window.physicalSize.height;
  // print("宽度 $width");
  runApp(MyApp());
}

void config() async {
  try {
    await dotenv.load(fileName: '.env');
    MQTTConfig.init();
    if (LeanCloudConfig.isValid()) {
      LeanCloud.initialize(LeanCloudConfig.appId, LeanCloudConfig.appKey,
          server: LeanCloudConfig.server, queryCache: new LCQueryCache());
      LCLogger.setLevel(LCLogger.DebugLevel);
    }
  } catch (e, stackTrace) {
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DysonPage(),
    );
  }
}
