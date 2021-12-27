import 'package:dyson_spherec_calculator/base/pages/aggregation_page.dart';
import 'package:dyson_spherec_calculator/base/pages/home_page.dart';
import 'package:dyson_spherec_calculator/sky/pages/time_page.dart';
import 'package:flutter/material.dart';

import 'dynamic_tab.dart';

class DysonTabStore {
  static final DynamicTab HOME_TAB =
      DynamicTab(0, "首页", Icon(Icons.home), null, (params) => HomePage());
  static final DynamicTab TIME_TAB =
      DynamicTab(1, "时间", Icon(Icons.timer), null, (params) => TimePage());
  static final DynamicTab DEMO_TAB =
      DynamicTab(2, "Demo", Icon(Icons.android), null, (params) => DemoPage());
  static final DynamicTab AGGREGATION_TAB = DynamicTab(
      3,
      "聚合",
      Icon(Icons.message),
      null,
      (params) => AggregationPage());

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
