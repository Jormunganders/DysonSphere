import 'package:dyson_sphere/base/pages/aggregation_page.dart';
import 'package:dyson_sphere/base/pages/home_page.dart';
import 'package:dyson_sphere/msi/msi_page.dart';
import 'package:dyson_sphere/sky/pages/mqtt_page.dart';
import 'package:dyson_sphere/sky/pages/time_page.dart';
import 'package:dyson_sphere/study/anim_page.dart';
import 'package:dyson_sphere/study/download_button.dart';
import 'package:dyson_sphere/tally/tally_page.dart';
import 'package:flutter/material.dart';

import 'dynamic_tab.dart';

class DysonTabStore {
  static var TAB_MAP = _generateTabMap();

  static List<int> getTopTabList() {
    return [
      TabKey.MQTT.index,
      TabKey.Time.index,
      TabKey.Demo.index,
      TabKey.AnimDemo.index,
      TabKey.AnimDemo2.index,
    ];
  }

  static List<int> getBottomTabList() {
    return [
      TabKey.Home.index,
      TabKey.Tally.index,
      TabKey.MSI.index,
      TabKey.Aggregation.index,
      TabKey.DownloadButtonDemo.index,
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
    _quickCreateDynamicTab(
      TabKey.Tally.index,
      name: "内库",
      icon: Icon(Icons.wallet_giftcard),
      page: TallyPage(),
    ),
    _quickCreateDynamicTab(
      TabKey.MSI.index,
      name: "MSI",
      icon: Icon(Icons.bolt),
      page: MSIPage(),
    ),
    _quickCreateDynamicTab(
      TabKey.MQTT.index,
      name: "MQTT",
      icon: Icon(Icons.device_hub),
      page: MQTTPage(),
    ),
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
  Tally,
  MSI,
  MQTT,
}
