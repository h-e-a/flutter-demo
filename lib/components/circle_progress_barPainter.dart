import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//圆形进度条加载
class CircleProgressBar extends StatefulWidget {
  final Color backgroundColor; //进度条背景颜色
  final Color foreColor; //进度条前景颜色
  final int duration; //动画时长
  final double size; //尺寸
  final bool textPercent; //是否使用百分比
  final double strokeWidth; //圆弧宽度
  final double startNumber; //开始的数字
  final double maxNumber; //结束的数字
  final TextStyle textStyle; //文字风格

  const CircleProgressBar(
    this.size, {
    this.backgroundColor = Colors.grey,
    this.foreColor = Colors.blueAccent,
    this.duration = 3000,
    this.strokeWidth = 10.0,
    this.textStyle,
    this.startNumber = 0.0,
    this.maxNumber = 360,
    this.textPercent = true,
  });
  @override
  _CircleProgressBarState createState() => _CircleProgressBarState();
}

class _CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  Animation<double> _doubleAnimation;
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;

  /*建立CurvedAnimation使用减速的插值器来模拟减速效果。然后结合Animation实现数值的变化
   然后把变化的值处理后赋给CircleProgressBarPainter的_sweepAngle*/

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _curvedAnimation = new CurvedAnimation(
        parent: _animationController, curve: Curves.decelerate);
    _doubleAnimation =
        new Tween(begin: widget.startNumber, end: widget.maxNumber)
            .animate(_curvedAnimation);
    _animationController.addListener(() {
      setState(() {});
    });
    onAnimationStart();
  }

  @override
  void reassemble() {
    onAnimationStart();
  }

  onAnimationStart() {
    _animationController.forward(from: widget.startNumber);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var percent = (_doubleAnimation.value / widget.maxNumber * 100).round();
    return Container(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: CircleProgressBarPainter(
            widget.strokeWidth,
            widget.backgroundColor,
            widget.foreColor,
            widget.startNumber / widget.maxNumber * 360,
            _doubleAnimation.value / widget.maxNumber * 360,
            widget.maxNumber / widget.maxNumber * 360),
        size: Size(widget.size, widget.size),
        child: Center(
          child: Text(
            "${_animationController.value.round() == widget.maxNumber ? "完成" : "${widget.textPercent ? "$percent%" : "${_doubleAnimation.value.round()}/${widget.maxNumber.round()}"}"}",
            style: widget.textStyle == null
                ? TextStyle(color: Colors.black, fontSize: 20)
                : widget.textStyle,
          ),
        ),
      ),
    );
  }
}

/*1
rad=(/180)1°=1/180rad,其中rad是弧度的单位、通常可以省略不写。
公式为:角度=180°×弧度÷π   弧度=角度×π÷180°
*/
class CircleProgressBarPainter extends CustomPainter {
  var _paintBckGround;
  var _paintFore;
  final _strokeWidth; //圆弧宽度
  final _backgroundColor; //	进度条背景颜色
  final _foreColor; //进度条前景颜色
  final _startAngle; //进度开始的角度
  final _sweepAngle; //扫过的角度
  final _endAngle; //结束角度
  CircleProgressBarPainter(
    this._strokeWidth,
    this._backgroundColor,
    this._foreColor,
    this._startAngle,
    this._sweepAngle,
    this._endAngle,
  ) {
    //进度条背景画笔
    _paintBckGround = new Paint()
      ..color = _backgroundColor
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;
    _paintFore = new Paint()
      ..color = _foreColor
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;
  }
  @override
  void paint(Canvas canvas, Size size) {
    //Rect 矩形
    var radius = size.width > size.height ? size.width / 2 : size.height / 2;
    Rect rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    //画背景
    canvas.drawCircle(Offset(radius, radius), radius, _paintBckGround);
    canvas.drawArc(rect, _startAngle / 180 * 3.14, _sweepAngle / 180 * 3.14,
        false, _paintFore);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return _sweepAngle != _endAngle;
  }
}
