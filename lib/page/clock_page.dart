import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        title: Text('时钟'),
      ),
      body: Center(
        child: CustomPaint(
          painter: TestPainter(),
        ),
      ),
    );
  }
}

class TestPainter extends CustomPainter {
  Paint _bigCirclePaint = new Paint()
    ..color = Colors.teal
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;
  Paint _linePaint = Paint()
    ..color = Colors.teal
    ..style = PaintingStyle.fill;
  TextPainter _textPainter = TextPainter(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
  );
  //中心点
  Offset _center = Offset(0, 0);
  //半径
  double _radius = min(500 / 3, 500 / 3);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(_center, _radius, _bigCirclePaint);
    _bigCirclePaint.style = PaintingStyle.fill;
    canvas.drawCircle(_center, _radius / 20, _bigCirclePaint);
    for (int i = 0; i < 60; i++) {
      //刻度的宽度
      _linePaint.strokeWidth = i % 5 == 0 ? (i % 3 == 0 ? 6 : 4) : 1;
      canvas.drawLine(
          Offset(0, _radius - 13), Offset(0, _radius - 8), _linePaint);
      canvas.rotate(pi / 30); //一个刻度为6°， 1° = π / 180  旋转弧度= π/180 * 6° =π/30
    }
    for (int i = 0; i < 12; i++) {
      canvas.save();
      canvas.translate(0.0, -_radius + 30);
      _textPainter.text = TextSpan(
        text: '${i == 0 ? '12' : i}',
        style: TextStyle(color: Colors.teal, fontSize: 21),
      );
      //数字旋转角度
      canvas.rotate(
          -deg2Rad(30) * i); //第i个数字转过了5*i个刻度=5*i*6°=30° 转过的弧度为30°*i *(π/180)
      _textPainter.layout();
      _textPainter.paint(
          canvas, Offset(-_textPainter.width / 2, -_textPainter.height / 2));
      //画布重置
      canvas.restore();
      canvas.rotate(deg2Rad(30));
    }

    int hours = DateTime.now().hour;
    int minutes = DateTime.now().minute;
    int seconds = DateTime.now().second;
    //时针
    double hourAngle = (hours - 12 + minutes / 60) * pi / 6;
    _linePaint.strokeWidth = 4;
    canvas.rotate(hourAngle);
    canvas.drawLine(Offset(0, 20), Offset(0, -_radius + 80), _linePaint);
    //分针
    double minutesAngle = (minutes + seconds / 60) * pi / 30;
    _linePaint.strokeWidth = 2;
    canvas.rotate(-hourAngle);
    canvas.rotate(minutesAngle);
    canvas.drawLine(Offset(0, 30), Offset(0, -_radius + 60), _linePaint);
    //秒针
    double secondsAngle = seconds * pi / 30;
    _linePaint.strokeWidth = 1;
    canvas.rotate(-minutesAngle);
    canvas.rotate(secondsAngle);
    canvas.drawLine(Offset(0, 40), Offset(0, -_radius + 30), _linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  num deg2Rad(num v) {
    return v * (pi / 180);
  }
}
