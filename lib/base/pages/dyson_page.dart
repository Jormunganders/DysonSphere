import 'package:dyson_spherec_calculator/base/dynamic_tab/dynamic_tab.dart';
import 'package:dyson_spherec_calculator/base/dynamic_tab/tab_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DysonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DysonPageState();
}

class _DysonPageState extends State<DysonPage> {
  // todo 支持传入
  var _currentIndex = 0;
  var tabKeyList = [];

  @override
  void initState() {
    tabKeyList = DysonTabStore.getBottomTabList()
        .where((key) => DysonTabStore.TAB_MAP.containsKey(key))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: tabKeyList.map((key) {
            DynamicTab tab = DysonTabStore.TAB_MAP[key]!;
            return BottomNavigationBarItem(
              icon: tab.icon ?? Icon(Icons.android),
              label: tab.name,
            );
          }).toList(),
          currentIndex: _currentIndex,
          fixedColor: Colors.blue,
          onTap: onItemSelect,
        ),
        body: DysonTabStore.TAB_MAP[tabKeyList[_currentIndex]]!.getPage());
  }

  void onItemSelect(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
