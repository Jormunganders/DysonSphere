import 'dart:ui';

import 'package:dyson_spherec_calculator/base/lean_cloud_config.dart';
import 'package:flutter/material.dart';
import 'package:dyson_spherec_calculator/base/values.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leancloud_storage/leancloud.dart';

import 'base/pages/dyson_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  if (LeanCloudConfig.isValid()) {
    LeanCloud.initialize(LeanCloudConfig.appId, LeanCloudConfig.appKey,
        server: LeanCloudConfig.server, queryCache: new LCQueryCache());
    LCLogger.setLevel(LCLogger.DebugLevel);
  }
  var width = window.physicalSize.height;
  print("宽度 $width");
  runApp(MyApp());
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
