import 'package:dyson_spherec_calculator/base/dynamic_tab/dynamic_tab.dart';
import 'package:dyson_spherec_calculator/base/dynamic_tab/tab_manager.dart';
import 'package:dyson_spherec_calculator/base/dynamic_tab/tab_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const HOME_PAGE_NAME = "首页";

class HomePage extends StatefulWidget {
  final int initSelectIndex;

  HomePage({this.initSelectIndex = 0});

  @override
  _HomePageState createState() => _HomePageState();
}

// 顶导三个 Tab 的设置
class _HomePageState extends State<HomePage> {
  var _tabManager = TabPageManager();

  @override
  void initState() {
    _tabManager.updateData(DysonTabStore.getTopTabList()
        .where((key) => DysonTabStore.TAB_MAP.containsKey(key))
        .toList());
    _tabManager.currentIndex = widget.initSelectIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var length = _tabManager.getTabList().length;
    return DefaultTabController(
      length: length,
      child: Scaffold(
        appBar: AppBar(
            title: Text(HOME_PAGE_NAME),
            bottom: TabBar(
              tabs: _tabManager
                  .getTabList()
                  .map((tabWrapper) => Tab(
                        icon: tabWrapper.icon,
                        text: tabWrapper.name,
                      ))
                  .toList(),
              isScrollable: length > 3,
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      final snackBar = SnackBar(
                        content: const Text('Hello, World!'),
                        action: SnackBarAction(
                          label: 'Good.',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Icon(Icons.airplanemode_on),
                  )),
            ]),
        body: TabBarView(
          children: _tabManager.getPageList().map((pageWrapper) => pageWrapper.realWidget).toList(),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Center(
                  child: Text("待施工"),
                ),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(
                  title: Text("设置"),
                  leading: Icon(Icons.settings),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {}),
              ListTile(
                title: Text("关闭"),
                onTap: () {
                  // close the drawer
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 暂时不用
class DemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '计数:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
