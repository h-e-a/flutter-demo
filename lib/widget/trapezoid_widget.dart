import 'package:flutter/material.dart';
import 'package:myexercises/tool/tool.dart';

class Trapezoid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TrapezoidPath(),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 250,
        decoration: BoxDecoration(color: Colors.orange),
        child: Text(
          'hhhhhhhhhhhhhhh',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class TrapezoidPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path();
    //梯形
    // path1.moveTo(0, size.height);
    // path1.lineTo(size.width / 3, 0);
    // path1.lineTo(size.width, size.height);
    // path1.moveTo(size.width * (2 / 3), 0);
    // path1.lineTo(size.width / 3, 0);
    // path1.lineTo(size.width, size.height);
    // path1.close();

    path1.lineTo(0, 0);
    path1.lineTo(0, size.height - 50);
    var firstPoint = Offset(size.width / 4, size.height);
    var secondPoint = Offset(size.width / 2, size.height - 50);
    path1.quadraticBezierTo(
        firstPoint.dx, firstPoint.dy, secondPoint.dx, secondPoint.dy);
    var thirdPoint = Offset(size.width * 0.75, size.height - 100);
    var fourthPoint = Offset(size.width, size.height - 50);
    path1.quadraticBezierTo(
        thirdPoint.dx, thirdPoint.dy, fourthPoint.dx, fourthPoint.dy);
    path1.lineTo(size.width, 40);
    var fivePoint = Offset(size.width * 0.75, 0);
    var sixthPoint = Offset(size.width / 2, 50);
    path1.quadraticBezierTo(
        fivePoint.dx, fivePoint.dy, sixthPoint.dx, sixthPoint.dy);
    var seventhPoint = Offset(size.width / 4, 100);
    var eightPoint = Offset(0, 50);
    path1.quadraticBezierTo(
        seventhPoint.dx, seventhPoint.dy, eightPoint.dx, eightPoint.dy);

    return path1;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
