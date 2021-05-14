import 'package:dyson_spherec_calculator/base/home/dyson_page.dart';
import 'package:dyson_spherec_calculator/base/home/home_page.dart';
import 'package:dyson_spherec_calculator/sky/pages/time_page.dart';
import 'package:flutter/material.dart';

import 'dynamic_tab.dart';

class DysonTabStore {
  static var HOME_TAB =
      DynamicTab(0, "首页", Icon(Icons.home), null, (params) => HomePage());
  static var TIME_TAB =
      DynamicTab(1, "时间", Icon(Icons.timer), null, (params) => TimePage());
  static var DEMO_TAB =
      DynamicTab(2, "Demo", Icon(Icons.android), null, (params) => DemoPage());
  static var AGGREGATION_TAB = DynamicTab(
      3,
      "聚合",
      Icon(Icons.message),
      null,
      (params) => Center(
            child: Text("聚合"),
          ));

  static var TAB_MAP = {
    HOME_TAB.key: HOME_TAB,
    TIME_TAB.key: TIME_TAB,
    DEMO_TAB.key: DEMO_TAB,
    AGGREGATION_TAB.key: AGGREGATION_TAB
  };

  static List<int> getTopTabList() {
    return [1, 2];
  }

  static List<int> getBottomTabList() {
    return [0, 3];
  }
}
