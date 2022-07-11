import 'package:flutter/material.dart';

import 'dio_log.dart';

///
/// Created by rich on 2019-07-31
///

OverlayEntry? itemEntry;

///显示全局悬浮调试按钮
showDebugBtn(BuildContext context, {Widget? button, Color? btnColor}) async {
  ///widget第一次渲染完成
  try {
    await Future.delayed(Duration(milliseconds: 500));
    dismissDebugBtn();
    itemEntry = OverlayEntry(
        builder: (BuildContext context) =>
            button ?? DraggableButtonWidget(btnColor: btnColor));

    ///显示悬浮menu
    Overlay.of(context)?.insert(itemEntry!);
  } catch (e) {}
}

///关闭悬浮按钮
dismissDebugBtn() {
  itemEntry?.remove();
  itemEntry = null;
}

///悬浮按钮展示状态
bool debugBtnIsShow() {
  return !(itemEntry == null);
}

class DraggableButtonWidget extends StatefulWidget {
  final String title;
  final Function? onTap;
  final double btnSize;
  final Color? btnColor;

  DraggableButtonWidget({
    this.title = 'http log',
    this.onTap,
    this.btnSize = 66,
    this.btnColor,
  });

  @override
  _DraggableButtonWidgetState createState() => _DraggableButtonWidgetState();
}

class _DraggableButtonWidgetState extends State<DraggableButtonWidget> {
  double left = 30;
  double top = 100;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    ///默认点击事件
    var tap = () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HttpLogListWidget(),
        ),
      );
    };
    Widget w;
    Color primaryColor = widget.btnColor ?? Theme.of(context).primaryColor;
    primaryColor = primaryColor.withOpacity(0.6);
    w = GestureDetector(
      onTap: widget.onTap as void Function()? ?? tap,
      onPanUpdate: _dragUpdate,
      child: Container(
        width: widget.btnSize,
        height: widget.btnSize,
        color: primaryColor,
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );

    ///圆形
    w = ClipRRect(
      borderRadius: BorderRadius.circular(widget.btnSize / 2),
      child: w,
    );

    ///计算偏移量限制
    if (left < 1) {
      left = 1;
    }
    if (left > screenWidth - widget.btnSize) {
      left = screenWidth - widget.btnSize;
    }

    if (top < 1) {
      top = 1;
    }
    if (top > screenHeight - widget.btnSize) {
      top = screenHeight - widget.btnSize;
    }
    w = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top),
      child: w,
    );
    return w;
  }

  _dragUpdate(DragUpdateDetails detail) {
    Offset offset = detail.delta;
    left = left + offset.dx;
    top = top + offset.dy;
    setState(() {});
  }
}
