import 'package:flutter/material.dart';

class DynamicTab {
  final int key;
  final String name;
  final Widget? icon;
  Widget? page;
  final Map<String, Object>? params;
  final PageCreatFunc pageCreatFunc;

  DynamicTab(this.key, this.name, this.icon, this.params, this.pageCreatFunc);

  Widget? getPage() {
    if (page == null) {
      return pageCreatFunc(params);
    }
    return page;
  }
}

typedef PageCreatFunc = Widget Function(Map<String, Object>?);
