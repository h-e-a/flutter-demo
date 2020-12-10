import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//随机颜色
Color ramColor() {
  return Color.fromARGB(
      255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
}

//返回bool值的确认弹窗
Future<bool> futureDialog(context, String titletext) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(30),
          contentPadding: EdgeInsets.all(0),
          title: Container(
            alignment: Alignment.center,
            child: Text(
              titletext,
              style: TextStyle(fontSize: 15),
            ),
          ),
          content: Row(
            children: <Widget>[
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Container(
                  color: Colors.green[200],
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("是"),
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("否"),
                ),
              ))
            ],
          ),
        );
      });
}

//底部选择器
bottomSelector(context, List list) {
  String selectorIndex = list[0];
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    child: Text("取消"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Spacer(),
                  InkWell(
                    child: Text("确定"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                    itemExtent: 50, //
                    onSelectedItemChanged: (index) {
                      selectorIndex = list[index];
                      print(selectorIndex);
                    },
                    children: list.map((item) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(item),
                      );
                    }).toList()),
              )
            ],
          ),
        );
      });
}

//聊天气泡
const _arrowWidth = 7.0; //箭头宽度
const _arrowHight = 10.0; //箭头宽度
const _minHeight = 32.0;
// const _minWidth = 50.0;
enum BubbleAlign { left, right }

class Demo extends StatelessWidget {
  final BubbleAlign align;
  final String text;
  Demo(this.text, {this.align = BubbleAlign.right});
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BubbleClip(align),
      child: Container(
        padding: EdgeInsets.only(
                left: align == BubbleAlign.left ? _arrowWidth : 0,
                right: align == BubbleAlign.left ? 0 : _arrowWidth)
            .add(EdgeInsets.all(10)),
        color: align != BubbleAlign.left ? Colors.green[300] : Colors.white,
        child: Text(
          text,
          style: TextStyle(
              color: align != BubbleAlign.left ? Colors.white : Colors.black,
              fontSize: 15),
        ),
      ),
    );
  }
}

class BubbleClip extends CustomClipper<Path> {
  final BubbleAlign align;

  BubbleClip(this.align);
  @override
  Path getClip(Size size) {
    final centerpoint = (size.height / 2); //指整个气泡的中心点
    // .clamp(_minHeight/2, _minHeight/2);
    Path path1 = new Path();
    path1.moveTo(align == BubbleAlign.left ? 0 : size.width, centerpoint);
    path1.lineTo(
        align == BubbleAlign.left ? _arrowWidth : size.width - _arrowWidth,
        centerpoint - _arrowHight / 2);
    path1.lineTo(
        align == BubbleAlign.left ? _arrowWidth : size.width - _arrowWidth,
        centerpoint + _arrowHight / 2);
    path1.close(); //闭合
    Path path2 = new Path();
    Rect rect = new Rect.fromLTWH(align == BubbleAlign.left ? _arrowWidth : 0,
        0, size.width - _arrowWidth, size.height);
    path2.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));
    path1.addPath(path2, Offset.zero);
    return path1;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

//
