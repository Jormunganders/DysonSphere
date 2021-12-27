import 'package:flutter/widgets.dart';

import 'loki_list_view.dart';

class AdapterManager with ChangeNotifier {
  static final Map<String, AdapterManager> _cache = <String, AdapterManager>{};

  factory AdapterManager(String? key) {
    if (key == null || key.isEmpty) {
      return new AdapterManager._internal();
    }
    return _cache.putIfAbsent(key, () => new AdapterManager._internal());
  }

  PageScene? scene;

  changePageSceneAndNotify(PageScene scene) {
    this.scene = scene;
    notifyDataChanged();
  }

  AdapterManager._internal();

  var _dataList = [];

  List<Delegate> _delegates = [];

  size() => _dataList.length;

  isEmpty() => _dataList.isEmpty;

  Editor edit() => new Editor(_dataList, this);

  notifyDataChanged() {
    notifyListeners();
  }

  Widget buildListItem(BuildContext context, int position,
      {Function? defaultBuilder}) {
    var item = _dataList[position];

    Delegate? selectDelegate;

    // 判断类型
    _delegates.forEach((Delegate delegate) {
      if (item.runtimeType == delegate.getType()) {
        if (delegate.isForType(item, position)) {
          selectDelegate = delegate;
        }
      }
    });

    if (selectDelegate == null) {
      if (defaultBuilder == null) {
        throw new Exception("没有找到对应的 Delegate");
      } else {
        return defaultBuilder(item, position);
      }
    }

    return selectDelegate!.getHolder().build(context, item, position);
  }

  AdapterManager registerDelegate(Delegate delegate) {
    _delegates.add(delegate);
    return this;
  }
}

class Editor {
  List data;

  AdapterManager _adapterManager;

  Editor(this.data, this._adapterManager);

  Editor add(dynamic item) {
    data.add(item);
    return this;
  }

  Editor insert(int index, dynamic item) {
    data.insert(index, item);
    return this;
  }

  Editor addAll(List list) {
    data.addAll(list);
    return this;
  }

  Editor clear() {
    data.clear();
    return this;
  }

  commit({PageScene scene = PageScene.LIST}) {
    _adapterManager.scene = scene;
    _adapterManager.notifyDataChanged();
  }
}

abstract class Delegate<D, V extends ViewHolder<D>> {
  isForType(D data, int position) => true;

  Type getType() {
    return D;
  }

  V getHolder();
}

abstract class ViewHolder<T> {
  Widget build(BuildContext context, T data, int position);
}

abstract class DelegateHolder<D> extends Delegate<D, ViewHolder<D>> {
  Widget build(BuildContext context, D data, int position);

  ViewHolder<D>? createCustomViewHolder() {
    return null;
  }

  @override
  ViewHolder<D> getHolder() {
    ViewHolder<D>? holder = createCustomViewHolder();
    if (holder != null) {
      return holder;
    }
    return BaseViewHolder(build);
  }
}

class BaseViewHolder<D> extends ViewHolder<D> {
  final HolderWidgetBuilder<D> _builder;

  BaseViewHolder(this._builder);

  @override
  Widget build(BuildContext context, D data, int position) {
    return _builder(context, data, position);
  }
}

typedef HolderWidgetBuilder<D> = Widget Function(
    BuildContext context, D data, int index);

typedef AdapterManagerProvider = AdapterManager Function();
