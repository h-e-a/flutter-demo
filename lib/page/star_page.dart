import 'package:flutter/material.dart';
import 'package:myexercises/widget/star_widget.dart';
import 'package:myexercises/widget/trapezoid_widget.dart';

class StarPage extends StatefulWidget {
  @override
  _StarPageState createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  // AnimationController _aC;
  // @override
  // void initState() {
  //   super.initState();
  //   _aC = AnimationController(
  //       duration: const Duration(milliseconds: 5000), vsync: this);
  //   _playAnimation();
  // }
  //
  // Future<Null> _playAnimation() async {
  //   try {
  //     //先正向执行动画
  //     await _aC.forward().orCancel;
  //     //再反向执行动画
  //     await _aC.reverse().orCancel;
  //   } on TickerCanceled {
  //     // the animation got canceled, probably because we were disposed
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   _aC.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: CustomPaint(
            painter: Star(num: 5, R: 100, r: 50, color: Colors.red),
          ),
        ),
        Trapezoid(),
      ],
    ));
  }
}

// class StarAnimation extends StatelessWidget {
//   final Animation<double> controller;
//   Animation<EdgeInsets> padding;
//
//   Animation<Color> color;
//
//   StarAnimation({Key key, this.controller}) : super(key: key) {
//     color = ColorTween(begin: Colors.blueGrey, end: Colors.red).animate(
//         CurvedAnimation(
//             parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));
//     padding =
//         Tween<EdgeInsets>(begin: EdgeInsets.all(0), end: EdgeInsets.all(50))
//             .animate(CurvedAnimation(
//                 parent: controller,
//                 curve: Interval(0.6, 1.0, curve: Curves.ease)));
//     return;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//         animation: controller,
//         builder: (context, child) {
//           return Container(
//             padding: padding.value,
//             child:
//           );
//         });
//   }
// }
