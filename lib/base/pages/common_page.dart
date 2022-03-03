import 'package:flutter/material.dart';

import '../colors.dart';
import '../strings.dart';

// ignore: must_be_immutable
class EmptyPage extends StatelessWidget {
  final String message;

  const EmptyPage({this.message = "还没有内容哦"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "graphics/image_empty.png",
            width: 210,
            fit: BoxFit.scaleDown,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: common_525252,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ErrorPage extends StatelessWidget {
  String message;
  String buttonText;
  VoidCallback onPress;

  ErrorPage(
      {this.message = error, this.buttonText = reload, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "graphics/image_error.png",
            width: 210,
            fit: BoxFit.scaleDown,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: common_525252,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: OutlinedButton(
              onPressed: onPress,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NoNetPage extends StatelessWidget {
  String message;
  String buttonText;
  VoidCallback onPress;

  NoNetPage(
      {this.message = no_net,
      this.buttonText = refresh,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "graphics/image_no_net.png",
            width: 210,
            fit: BoxFit.scaleDown,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: common_525252,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: OutlinedButton(
              onPressed: onPress,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpinKitRotatingPlain extends StatefulWidget {
  const SpinKitRotatingPlain({
    Key? key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        assert(size != null),
        super(key: key);

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  _SpinKitRotatingPlainState createState() => _SpinKitRotatingPlainState();
}

class _SpinKitRotatingPlainState extends State<SpinKitRotatingPlain>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1, _animation2;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() => setState(() {}))
      ..repeat();
    _animation1 = Tween(begin: 0.0, end: 180.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn)));
    _animation2 = Tween(begin: 0.0, end: 180.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4.identity()
          ..rotateX((0 - _animation1.value) * 0.0174533)
          ..rotateY((0 - _animation2.value) * 0.0174533),
        alignment: FractionalOffset.center,
        child: SizedBox.fromSize(
          size: Size.square(widget.size),
          child: _itemBuilder(0),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(decoration: BoxDecoration(color: widget.color));
}
