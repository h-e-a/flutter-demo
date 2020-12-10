import 'dart:math';

import 'package:flutter/material.dart';

class Star extends CustomPainter {
  final int num;
  final double R;
  final double r;
  final Color color;
  Paint mPaint;
  Star({this.num, this.R, this.r, this.color}) {
    mPaint = new Paint();
    mPaint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(starPath(), mPaint);
  }

  Path starPath() {
    Path path = new Path();
    double perDeg = 360 / num;
    double degA = perDeg / 4;
    double degB = (360 / (num - 1) - degA) / 2 + degA;

    path.moveTo(cos(_rad(degA)) * R, (-sin(_rad(degA)) * R));
    for (int i = 0; i < num; i++) {
      path.lineTo(
          cos(_rad(degA + perDeg * i)) * R, -sin(_rad(degA + perDeg * i)) * R);
      path.lineTo(
          cos(_rad(degB + perDeg * i)) * r, -sin(_rad(degB + perDeg * i)) * r);
    }
    path.close();
    return path;
  }

  double _rad(double deg) {
    return deg * pi / 180;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
