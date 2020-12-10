import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tool/chat_tool.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

typedef DoubleTest = Function(dynamic data);

class _ChatPageState extends State<ChatPage> {
  TextEditingController _text = new TextEditingController();
  @override
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  List _chatList = [
    {
      "text": "找个时间一起出来吧",
      "isOwner": 2,
    },
    {
      "text": "我们好久没见面了~",
      "isOwner": 2,
    },
    {
      "text": "好吗",
      "isOwner": 2,
    },
    {"text": "啊这啊这啊这", "isOwner": 1}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.chevron_left,
            color: Colors.black54,
            size: 35,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "对方正在输入…",
          style: TextStyle(fontSize: 17, color: Colors.black),
        ),
        actions: <Widget>[
          Icon(
            Icons.more_horiz,
            color: Colors.black54,
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: _chatList.length,
                  itemBuilder: (context, index) {
                    return ChatList(
                      text: _chatList[index]["text"],
                      isOwner: _chatList[index]["isOwner"],
                      chatList: _chatList,
                      doubleTest: (data) {
                        if (data == 1) {
                          _chatList.add({"text": "你拍了拍自己", "isOwner": 3});
                        } else {
                          _chatList.add({"text": "你拍了拍程可媛", "isOwner": 3});
                        }
                        setState(() {});
                      },
                    );
                  },
                )),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.grey[300]))),
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.network(
                        "http://m.qpic.cn/psc?/V11woKXe1afxqI/qWkkGOdvaHRbO0s2SzmJ0KXpv79.IQJ92MfZ7OVjS3zrYNtglm3Sp8Uq3PvKz2MRL922hvI.UwehWtJAf.nWqA!!/b&bo=yADIAAAAAAADByI!&rf=viewer_4",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 10, bottom: 10)),
                          controller: _text,
                          onSubmitted: (str) {
                            setState(() {
                              if (_text.text.isEmpty) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("请输入内容"),
                                  action: SnackBarAction(
                                    label: "好的",
                                    onPressed: () => null,
                                  ),
                                ));
                                return;
                              }
                              _chatList.insert(_chatList.length,
                                  {"text": str, "isOwner": 1});
                              _text.clear();
                            });
                          },
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.sentiment_satisfied,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.add_circle_outline,
                        size: 30,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ChatList extends StatefulWidget {
  final int isOwner;
  final String text;
  final List chatList;
  final DoubleTest doubleTest;
  ChatList({
    Key key,
    this.isOwner,
    this.text,
    this.chatList,
    this.doubleTest,
  }) : super(key: key);
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> body = widget.isOwner == 3
        ? [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(widget.text),
            )
          ]
        : [
            SizedBox(
              width: 10,
            ),
            ChatAvatar(
              avatarisOwner: widget.isOwner,
              doubleTest: widget.doubleTest,
              widgets: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  widget.isOwner == 1
                      ? "http://m.qpic.cn/psc?/V11woKXe1afxqI/qWkkGOdvaHRbO0s2SzmJ0KEa**WjTDPRJ4d3BIwDnYBcIBFVlJ8J1OazAQ6mCgM.vTcYu3GLSMsRX9Mltvd8cg!!/b&bo=OAE4AQAAAAARBzA!&rf=viewer_4"
                      : "http://up.enterdesk.com/edpic/0d/c4/f4/0dc4f46b76f00187b04d52e94fe786d6.jpg",
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: UnconstrainedBox(
                  alignment: widget.isOwner == 1
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Demo(
                    widget.text,
                    align: widget.isOwner == 1
                        ? BubbleAlign.right
                        : BubbleAlign.left,
                  )),
              flex: 3,
            ),
            Spacer()
          ];
    if (widget.isOwner == 1) {
      body = body.reversed.toList();
    }
    // body = body.reversed.toList();
    //加判断可以区分方向
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(children: body),
    );
  }
}

class ChatAvatar extends StatefulWidget {
  final int avatarisOwner;
  final DoubleTest doubleTest;
  final Widget widgets;
  ChatAvatar({
    Key key,
    this.avatarisOwner,
    this.doubleTest,
    this.widgets,
  }) : super(key: key);
  @override
  _ChatAvatarState createState() => _ChatAvatarState();
}

class _ChatAvatarState extends State<ChatAvatar> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  start() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 10), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 10, end: 0), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: -10), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: -10, end: 0), weight: 1),
    ]).animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        widget.doubleTest(widget.avatarisOwner);
        start();
      },
      child: AnimateWidget(child: widget.widgets, animation: animation),
    );
  }
}

class AnimateWidget extends AnimatedWidget {
  final Widget child;

  AnimateWidget({Animation<double> animation, this.child})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    var result = Transform(
      transform: Matrix4.rotationZ(animation.value * pi / 180),
      alignment: Alignment.bottomCenter,
      child: this.child,
    );
    return result;
  }
}
