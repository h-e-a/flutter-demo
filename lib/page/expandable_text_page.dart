import 'package:flutter/material.dart';

class ExpandableTextPage extends StatefulWidget {
  static void show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ExpandableTextPage();
    }));
  }

  @override
  State<StatefulWidget> createState() {
    return _ExpandableTextPageState();
  }
}

class _ExpandableTextPageState extends State<ExpandableTextPage> {
  @override
  Widget build(BuildContext context) {
    String shortText = '不超过最大行数三行的多行文本不超过最大行数三行的多行文本';

    String longText = '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本'
        '超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本超过最大行数三行的多行文本';

    return Scaffold(
      appBar: AppBar(
        title: Text('仿朋友圈多行文字展开收起'),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('短文本测试：'),
            Container(
              color: Colors.yellow,
              child: ExpandableText(
                text: shortText,
                maxLines: 3,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Text('长文本测试：'),
            Container(
              color: Colors.yellow,
              child: ExpandableText(
                text: longText,
                maxLines: 3,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  final int maxLines;

  final TextStyle style;

  final bool expand;

  const ExpandableText(
      {Key key, this.text, this.maxLines, this.style, this.expand})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExpandableTextState(text, maxLines, style, expand);
  }
}

class _ExpandableTextState extends State<ExpandableText> {
  final String text;

  final int maxLines;

  final TextStyle style;

  bool expand;

  _ExpandableTextState(this.text, this.maxLines, this.style, this.expand) {
    if (expand == null) {
      expand = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(text: text ?? '', style: style);

      final tp = TextPainter(
          text: span, maxLines: maxLines, textDirection: TextDirection.ltr);

      tp.layout(maxWidth: size.maxWidth);

      if (tp.didExceedMaxLines) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            expand
                ? Text(text ?? '', style: style)
                : Text(text ?? '',
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                    style: style),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  expand = !expand;
                });
              },
              child: Container(
                padding: EdgeInsets.only(top: 2),
                child: Text(expand ? '收起' : '全文',
                    style: TextStyle(
                        fontSize: style != null ? style.fontSize : null,
                        color: Colors.blue)),
              ),
            ),
          ],
        );
      } else {
        return Text(text ?? '', style: style);
      }
    });
  }
}
