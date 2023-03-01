import 'package:dyson_sphere/base/dynamic_tab/dynamic_tab.dart';
import 'package:dyson_sphere/base/dynamic_tab/tab_manager.dart';
import 'package:dyson_sphere/base/dynamic_tab/tab_store.dart';
import 'package:dyson_sphere/base/utils/ext.dart';
import 'package:flutter/material.dart';

class DysonPage extends StatefulWidget {
  final int initSelectIndex;

  DysonPage({this.initSelectIndex = 0});

  @override
  State<StatefulWidget> createState() => _DysonPageState();
}

class _DysonPageState extends State<DysonPage> {
  var _tabManager = TabPageManager();

  @override
  void initState() {
    _tabManager.updateData(DysonTabStore.getBottomTabList()
        .where((key) => DysonTabStore.TAB_MAP.containsKey(key))
        .toList());
    _tabManager.currentIndex = widget.initSelectIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: _tabManager
              .getTabList()
              .map((tabWrapper) => BottomNavigationBarItem(
                  icon: tabWrapper.icon, label: tabWrapper.name))
              .toList(),
          currentIndex: _tabManager.currentIndex,
          fixedColor: Colors.blue,
          unselectedItemColor: Colors.black26,
          onTap: onItemSelect,
        ),
        body: _tabManager.getCurrentPage().realWidget.apply((e) => {print(e)}));
  }

  void onItemSelect(int index) {
    setState(() {
      _tabManager.currentIndex = index;
    });
  }
}

/*tabKeyList.map((key) {
                DynamicTab tab = DysonTabStore.TAB_MAP[key]!;
                return Tab(
                  icon: tab.icon,
                  text: tab.name,
                );
              }).toList()*/