import 'package:dyson_spherec_calculator/base/pages/aggregation_page.dart';
import 'package:dyson_spherec_calculator/base/pages/home_page.dart';
import 'package:dyson_spherec_calculator/sky/pages/time_page.dart';
import 'package:dyson_spherec_calculator/study/anim_page.dart';
import 'package:dyson_spherec_calculator/study/download_button.dart';
import 'package:flutter/material.dart';

import 'dynamic_tab.dart';

class DysonTabStore {
  static var TAB_MAP = _generateTabMap();

  static List<int> getTopTabList() {
    return [
      TabKey.Time.index,
      TabKey.Demo.index,
      TabKey.AnimDemo.index,
      TabKey.AnimDemo2.index
    ];
  }

  static List<int> getBottomTabList() {
    return [
      TabKey.Home.index,
      TabKey.Aggregation.index,
      TabKey.DownloadButtonDemo.index
    ];
  }

  static final _sTabList = [
    _quickCreateDynamicTab(TabKey.Home.index,
        name: "首页", icon: Icon(Icons.home), page: HomePage()),
    _quickCreateDynamicTab(TabKey.Time.index,
        name: "时间", icon: Icon(Icons.timer), page: TimePage()),
    _quickCreateDynamicTab(TabKey.Demo.index,
        name: "Demo", icon: Icon(Icons.android), page: DemoPage()),
    _quickCreateDynamicTab(TabKey.Aggregation.index,
        name: "聚合", icon: Icon(Icons.message), page: AggregationPage()),
    _quickCreateDynamicTab(TabKey.AnimDemo.index,
        name: "Anim Demo",
        icon: Icon(Icons.animation),
        page: AnimatedContainerApp()),
    _quickCreateDynamicTab(TabKey.AnimDemo2.index,
        name: "Anim Demo 2",
        icon: Icon(Icons.ac_unit),
        page: OpacityAnimDemoPage()),
    _quickCreateDynamicTab(TabKey.DownloadButtonDemo.index,
        name: "列表",
        icon: Icon(Icons.download),
        page: ExampleCupertinoDownloadButton()),
  ];

  static DynamicTab _quickCreateDynamicTab(int key,
      {String name = "TAB", Widget? icon, required Widget page}) {
    return DynamicTab(key, name, icon, null, (params) => page);
  }

  static Map<int, DynamicTab> _generateTabMap() {
    Map<int, DynamicTab> map = Map();
    _sTabList.forEach((element) {
      map.putIfAbsent(element.key, () => element);
    });
    return map;
  }
}

enum TabKey {
  Home,
  Time,
  Demo,
  Aggregation,
  AnimDemo,
  AnimDemo2,
  DownloadButtonDemo,
}
