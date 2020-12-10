import 'package:flutter/material.dart';

import 'dart:math';

//添加到购物车的小红点

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _key = GlobalKey();
  Offset _endOffset;

  AnimationController _ac;
  int num = 0;
  @override
  void initState() {
    _ac =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//    RenderBox screenObject = _screenKey.currentContext.findRenderObject();
//    final screenPosition = screenObject.localToGlobal(Offset.zero);
//    _curX = screenPosition.dx;
//    _curY = screenPosition.dy;

    WidgetsBinding.instance.addPostFrameCallback((c) {
      //获取购物车图标的位置
      _endOffset = (_key.currentContext.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);
    });
    super.initState();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('添加到购物车'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Text(' 我是商品${index + 1}'),
                    ),
                    Builder(builder: (context) {
                      return IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          //点击的时候获取当前的widget位置，传入overlayEntry
                          var _overlayEntry = OverlayEntry(builder: (_) {
                            RenderBox box = context.findRenderObject();
                            var offset = box.localToGlobal(Offset.zero);
                            return RedDotPage(
                              startPosition: offset,
                              endPosition: _endOffset,
                            );
                          });
                          //显示Overlay
                          Overlay.of(context).insert(_overlayEntry);
                          //等待动画结束
                          Future.delayed(Duration(milliseconds: 800), () {
                            _overlayEntry.remove();
                            _overlayEntry = null;
                            setState(() {
                              num <= 100 ? num++ : num = 0;
                            });
                            _ac.reset();

                            _ac.forward();
                          });
                        },
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.shopping_cart,
                          key: _key,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        right: 3,
                        top: 3,
                        child: ScaleTransition(
                          scale: CurvedAnimation(
                              parent: _ac, curve: Curves.linearToEaseOut),
                          child: Container(
                            width: 18,
                            height: 18,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              '$num',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///小红点动画
class RedDotPage extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;

  const RedDotPage({Key key, this.startPosition, this.endPosition})
      : super(key: key);

  @override
  _RedDotPageState createState() => _RedDotPageState();
}

class _RedDotPageState extends State<RedDotPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller; // 动画 controller
  Animation<double> _animation; // 动画
  double left; // 小圆点的left（动态计算）
  double top; // 小远点的right（动态计算）
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    // 二阶贝塞尔曲线用值
    var x0 = widget.startPosition.dx;
    var y0 = widget.startPosition.dy;

    var x1 = widget.startPosition.dx - 250;
    var y1 = widget.startPosition.dy - 100;

    var x2 = widget.endPosition.dx + 25;
    var y2 = widget.endPosition.dy;

    _animation.addListener(() {
      // t 动态变化的值
      var t = _animation.value;
      if (mounted)
        setState(() {
          //P0（起点），P1（控制点），P2（终点）
          //B(t)=(1-t)²P0+2t(1-t)P1 +t²P2,t∈[0,1] //二阶贝塞尔曲线
          left = pow(1 - t, 2) * x0 + 2 * t * (1 - t) * x1 + pow(t, 2) * x2;
          top = pow(1 - t, 2) * y0 + 2 * t * (1 - t) * y1 + pow(t, 2) * y2;
        });
    });

    // 初始化小圆点的位置
    left = widget.startPosition.dx;
    top = widget.startPosition.dy;

    // 显示小圆点的时候动画就开始
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // 用 Stack -> Positioned 来控制小圆点的位置
    return Stack(
      children: <Widget>[
        Positioned(
          left: left,
          top: top,
          child: ClipOval(
            child: Container(
              width: 14,
              height: 14,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
