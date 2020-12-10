import 'package:flutter/material.dart';
import 'package:myexercises/page/qa_details_publisher_page.dart';
import 'package:myexercises/tool/tool.dart';

class QaDetailsAnswerListItemWidget extends StatelessWidget {
  final Widget widget;

  //判断是否采用
  final bool adopted;

  DetailsPublisherListItemModel data;

  QaDetailsAnswerListItemWidget({Key key, this.widget, this.adopted, this.data})
      : super(key: key) {
    this.data == null
        ? this.data = DetailsPublisherListItemModel(
            name: '未知姓名',
            date: '未知时间',
            content: '未知内容',
          )
        : this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 7, color: Color(0xffF5F5F5)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///头像和采纳图标
          Column(
            children: <Widget>[
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage(
                    'https://m.qpic.cn/psc?/V13QrEh00DsmO9/bqQfVz5yrrGYSXMvKr.cqfLzoL11H1oCdtwttGJzx8CJfZADG1Ya1rtg1uL7mAKM2wVKm.q4Jsfz5zUyWHoS730FqfX30*KJts7Z0mlp2e4!/b&bo=WQBZAAAAAAADByI!&rf=viewer_4'),
              ),

              SizedBox(height: 15),

              ///是否采纳
              adopted
                  ? Image.asset(
                      choiceAnswer(data.type),
                      width: 22,
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(width: 5),

          ///发表答案人的信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ///发表答案人的姓名
                              Text('${data.name}',
                                  style: textStyle(
                                      color: Color(0xff262626), size: 12)),
                              SizedBox(width: 5),

                              ///发表答案人性别
                              Image.asset('assets/gender.png')
                            ],
                          ),

                          ///答案发表的时间和日期

                          Text(
                            '${data.date}',
                            style: textStyle(color: Color(0xff8c8c8c8)),
                          ),
                        ]),
                    Spacer(),

                    ///（默认） => 回答者答案评论数量和点赞的图标
                    //当不传widget且已经采纳公布答案时候显示报酬金额否则显示(默认）
                    widget == null
                        ? adopted
                            ? adopterAnswer(data.type)
                            : Row(
                                children: <Widget>[
                                  Image.asset('assets/comment.png'),
                                  SizedBox(width: 16),
                                  Text('10',
                                      style:
                                          textStyle(color: Color(0xffbfbfbf))),
                                  Image.asset('assets/like.png'),
                                  SizedBox(width: 32),
                                  Image.asset('assets/more.png'),
                                ],
                              )
                        : widget,
                  ],
                ),
                SizedBox(height: 15),

                ///回答内容
                Text(
                  '${data.content}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(color: Color(0xff212121), size: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //判断答案是否被选用
  String choiceAnswer(String type) {
    switch (type) {
      case '最佳答案':
        return 'assets/best_answer.png';
        break;
      case '优秀答案':
        return 'assets/adopted.png';
        break;
      default:
        return 'assets/not_adopted.png';
    }
  }

  ///判断答案是否采纳和采纳的类型 判断问答是否完结
  Widget adopterAnswer(String type) {
    String _answerType;
    Color _borderColor;
    switch (type) {
      case '最佳答案':
        _answerType = '获酬￥10.00';
        _borderColor = Color(0xfff6bd16);
        break;
      case '优秀答案':
        _answerType = '获酬￥2.00';
        _borderColor = Color(0xfff7ebffc);
        break;
      default:
        _answerType = '谢谢参与';
        _borderColor = Color(0xfffff7ae0);
    }
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(border: Border.all(color: _borderColor)),
      child: Text(
        '$_answerType',
        style: textStyle(color: _borderColor),
      ),
    );
  }
}
