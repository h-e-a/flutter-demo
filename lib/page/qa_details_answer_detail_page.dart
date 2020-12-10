import 'package:flutter/material.dart';
import 'package:myexercises/page/qa_details_publisher_page.dart';
import 'package:myexercises/tool/tool.dart';

///问答-详情-发布者-查询答案
class QaDetailsAnswerDetailPage extends StatefulWidget {
  final DetailsPublisherListItemModel data;

  const QaDetailsAnswerDetailPage({Key key, this.data}) : super(key: key);
  @override
  _QaDetailsAnswerDetailPageState createState() =>
      _QaDetailsAnswerDetailPageState();
}

class _QaDetailsAnswerDetailPageState extends State<QaDetailsAnswerDetailPage> {
  ///判断选中为最佳答案或者优秀答案 true为最佳答案 false为优秀答案
  bool _choice = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            child: Image.asset('assets/back.png'),
            onTap: () => Navigator.pop(context)),
        title: Text('答案', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          InkWell(
            child: Image.asset('assets/list.png'),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          //头像姓名 性别 发表日期
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ///头像
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                          'https://m.qpic.cn/psc?/V13QrEh00DsmO9/bqQfVz5yrrGYSXMvKr.cqfLzoL11H1oCdtwttGJzx8CJfZADG1Ya1rtg1uL7mAKM2wVKm.q4Jsfz5zUyWHoS730FqfX30*KJts7Z0mlp2e4!/b&bo=WQBZAAAAAAADByI!&rf=viewer_4'),
                    ),
                    SizedBox(width: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ///发表答案人的姓名
                              Text('${widget.data.name}',
                                  style: textStyle(
                                      color: Color(0xff262626), size: 12)),
                              SizedBox(width: 5),

                              ///发表答案人性别
                              Image.asset('assets/gender.png')
                            ],
                          ),

                          ///答案发表的时间和日期

                          Text(
                            '${widget.data.date}',
                            style: textStyle(color: Color(0xff8c8c8c8)),
                          ),
                        ]),
                    Spacer(),

                    ///评论图标
                    Image.asset('assets/comment.png'),
                    SizedBox(width: 16),
                    Text('10', style: textStyle(color: Color(0xffbfbfbf))),

                    ///点赞图标
                    Image.asset('assets/like.png'),
                    SizedBox(width: 32),

                    ///更多图标
                    Image.asset('assets/more.png'),
                  ],
                ),

                SizedBox(height: 15),

                //答案内容详情
                Text(
                  '${widget.data.content}',
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          ///选用按钮
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            color: Colors.white,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              minWidth: 40,
              height: 25,
              elevation: 0,
              color: Color(0xff1890FF),
              child:
                  Text('选用', style: textStyle(color: Colors.white, size: 14)),
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: (context) => showBottomSheet());
              },
            ),
          ),
        ],
      ),
    );
  }

  ///顶部选择弹出框
  Widget showBottomSheet() {
    return StatefulBuilder(
      builder: (context1, state) {
        Widget choiceItem(String title, bool choice) {
          return InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Text('选为  $title',
                        style: textStyle(color: Color(0xff4d4d4d), size: 14)),
                    Spacer(),
                    choice
                        ? Icon(
                            Icons.check_circle_outline,
                            color: Color(0xff1890ff),
                            size: 16,
                          )
                        : SizedBox()
                  ],
                ),
              ),
              onTap: () {
                state(() => _choice = !_choice);
                print(_choice);
              });
        }

        return Stack(
          children: <Widget>[
            Container(
              height: 25,
              width: double.infinity,
              color: Colors.black54,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        choiceItem('最佳答案', _choice),
                        choiceItem('优秀答案', !_choice),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffF5F5F5),
                    thickness: 10,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        child: Text('取消',
                            style:
                                textStyle(color: Color(0xff8c8c8c), size: 16)),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      InkWell(
                        child: Text('确定',
                            style:
                                textStyle(color: Color(0xff1890ff), size: 16)),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
