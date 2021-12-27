import 'package:flutter/material.dart';
import 'package:dyson_spherec_calculator/base/values.dart';

import 'base/pages/dyson_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
