// 这里存放的是每个页面存储的 Page 对象
// Page 对象的 K-V
// 对应的 Tab 对象，需要另一个数据结构封装一个
// 当前选中的页面 index
import 'dart:collection';

import 'package:dyson_spherec_calculator/base/dynamic_tab/dynamic_tab.dart';
import 'package:dyson_spherec_calculator/base/dynamic_tab/tab_store.dart';
import 'package:flutter/material.dart';

import '../pages/common_page.dart';

typedef PageUpdater = PageWrapper Function(PageWrapper cache, int id);

class TabPageManager {
  var _currentIndex = -1; // 当前选中的页面

  TabPageManager() {
    _defaultTabWrapper = TabWrapper(-1);
    _defaultPageWrapper = PageWrapper(_defaultTabWrapper.id);
  }

  Map<int, PageWrapper> _pageMap = new HashMap();
  List<TabWrapper> _tabList = List.empty(growable: true);
  late final TabWrapper _defaultTabWrapper;
  late final PageWrapper _defaultPageWrapper;

  set currentIndex(int index) {
    _currentIndex = index;
  }

  int get currentIndex {
    return _currentIndex;
  }

  /// 更新数据源
  TabPageManager updateData(List<int> tabIdList, {PageUpdater? updater}) {
    //todo merge 策略
    _tabList.clear();
    // 构建 tabList
    tabIdList.forEach((id) {
      var dynamicTab = DysonTabStore.TAB_MAP[id];
      if (dynamicTab != null) {
        _tabList.add(
          TabWrapper(dynamicTab.key,
              icon: dynamicTab.icon ?? const Icon(Icons.android),
              name: dynamicTab.name),
        );
      }
    });
    // 构建 PageMap，默认会复用之前的 Page
    // todo 这里可以改成懒加载
    _tabList.forEach((tabWrapper) {
      PageWrapper newPageWrapper;
      var id = tabWrapper.id;
      if (_pageMap.containsKey(tabWrapper.id)) {
        // 发生冲突，自行处理冲突问题，默认是复用之前的 Page
        var cachePageWrapper = _pageMap[id];
        PageUpdater realUpdater = updater ?? defaultPageUpdater;
        newPageWrapper = realUpdater(cachePageWrapper!, id);
      } else {
        // 直接从 TabStore 中创建 Page
        newPageWrapper =
            PageWrapper(id, widget: DysonTabStore.TAB_MAP[id]?.getPage());
      }
      _pageMap[id] = newPageWrapper;
    });
    return this;
  }

  PageWrapper getCurrentPage() {
    return getPage(_currentIndex);
  }

  PageWrapper getPage(int index) {
    if (_tabList.isEmpty) {
      return _defaultPageWrapper;
    }
    if (index < 0 || index >= _tabList.length) {
      return _defaultPageWrapper;
    }
    var tab = _tabList[index];
    if (!_pageMap.containsKey(tab.id)) {
      return _defaultPageWrapper;
    }
    return _pageMap[tab.id]!;
  }

  List<PageWrapper> getPageList() {
    return getTabList().map((tabWrapper) {
      if (_pageMap.containsKey(tabWrapper.id)) {
        return _pageMap[tabWrapper.id]!;
      } else {
        return _defaultPageWrapper;
      }
    }).toList();
  }

  List<TabWrapper> getTabList() {
    return List.from(_tabList, growable: false);
  }

  PageWrapper defaultPageUpdater(PageWrapper cache, int id) {
    return cache;
  }
}

class TabWrapper {
  Widget icon;
  String name;
  final int id;

  // todo 一些其他的数据

  TabWrapper(this.id,
      {this.icon = const Icon(Icons.android), this.name = "Flutter"});

  @override
  String toString() {
    return 'TabWrapper{icon: $icon, name: $name, id: $id}';
  }
}

class PageWrapper {
  Widget? widget;
  final int _id;

  // todo 一些其他的数据

  PageWrapper(this._id, {this.widget});

  Widget get realWidget {
    if (this.widget == null) {
      return const EmptyPage();
    }
    return this.widget!;
  }

  @override
  String toString() {
    return 'PageWrapper{widget: $widget, _id: $_id}';
  }
}
