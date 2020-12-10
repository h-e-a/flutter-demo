import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myexercises/tool/tool.dart';

import 'qa_details_answer_detail_page.dart';
import 'qa_details_answer_list_item_widget.dart';
import 'qa_details_answer_list_page.dart';

///问答-详情-发布者页面
class QaDetailPublisherPage extends StatefulWidget {
  @override
  _QaDetailPublisherPageState createState() => _QaDetailPublisherPageState();
}

class _QaDetailPublisherPageState extends State<QaDetailPublisherPage> {
  //问题是否完结
  bool finish = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            child: Image.asset('assets/back.png'),
            onTap: () => Navigator.pop(context)),
        title: Text('问答', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          InkWell(
            child: Image.asset('assets/share.png'),
            onTap: () {
              setState(() {
                ///测试按钮 点击按钮底部ListView为已公布
                setState(() {
                  finish = !finish;
                });
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ///问题
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///标题
                Text('为什么有些人喝完牛奶会拉肚子？'),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff7EBFFC), width: 1),
                      ),
                      child: Text('问答',
                          style: textStyle(color: Color(0xff7EBFFC))),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '李清照',
                      style: textStyle(color: Color(0xff595959)),
                    ),
                    SizedBox(width: 8),

                    ///发布日期
                    Text(
                      '2020-03-28',
                      style: textStyle(color: Color(0xff8C8C8C)),
                    ),
                    Spacer(),

                    ///截止日期
                    Text(
                      '截止日期: 2020-06-30 23 :59',
                      style: textStyle(color: Color(0xff8C8C8C)),
                    ),
                  ],
                ),
                SizedBox(height: 23),

                ///问答活动开始时间
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("问题",
                        style: textStyle(
                            color: Color(0xff212121),
                            size: 16,
                            weight: FontWeight.w700)),
                    finish
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xffff7ae0), width: 1)),
                            child: Text(
                              '已完结',
                              style: textStyle(color: Color(0xffff7ae0)),
                            ),
                          )
                        : Text(
                            '本活动将于2020-05-30 00:00开始',
                            style: textStyle(color: Color(0xff7EBFFC)),
                          ),
                  ],
                ),
                SizedBox(height: 17),
                Text('我每次喝牛奶肚子都不舒服，这是为什么？总不能从此就不喝牛奶了吧，有大神能给个解释吗？',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle(color: Color(0xff212121), size: 14)),
                SizedBox(height: 18),
              ],
            ),
          ),

          Divider(thickness: 10, color: Color(0xffF5F5F5)),

          ///详情
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('详情',
                    style: textStyle(
                        color: Color(0xff212121),
                        size: 16,
                        weight: FontWeight.w700)),

                SizedBox(height: 20),

                ///发布者
                Row(
                  children: <Widget>[
                    Text('发布者',
                        style: textStyle(color: Color(0xff595959), size: 14)),
                    Spacer(),
                    Text('李清照',
                        style: textStyle(color: Color(0xff1890FF), size: 14)),
                  ],
                ),

                SizedBox(height: 20),

                ///报酬总额
                Row(
                  children: <Widget>[
                    Text('报酬总额',
                        style: textStyle(color: Color(0xff595959), size: 14)),
                    Spacer(),
                    Text('￥20.00',
                        style: textStyle(color: Color(0xff1890FF), size: 14)),
                  ],
                ),

                SizedBox(height: 10),
              ],
            ),
          ),

          Divider(thickness: 10, color: Color(0xffF5F5F5)),

          ///答案列表
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    ///点击跳转到答案啊列表页面
                    InkWell(
                        child: Text(
                          '答案列表',
                          style: textStyle(
                              color: Color(0xff212121),
                              size: 16,
                              weight: FontWeight.w700),
                        ),
                        onTap: () => _navigateAnswerListPage(context)),
                    SizedBox(width: 24),

                    ///评论列表跳转

                    InkWell(
                      child: Text('评论列表',
                          style: textStyle(color: Color(0xffbfbfbf), size: 16)),
                    ),
                    Spacer(),
                    Text('50人参与',
                        style: textStyle(color: Color(0xffbfbfbf), size: 12)),
                    finish ? SizedBox() : SizedBox(width: 16),
                    finish
                        ? SizedBox()
                        : InkWell(
                            child: Image.asset('assets/list.png', width: 25),
                          ),
                  ],
                ),
              ),

              ///答案列表ListView
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    ///点击跳转到回答详细页
                    return InkWell(
                      child: QaDetailsAnswerListItemWidget(
                        adopted: finish,
                        data: list[index],
                      ),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => QaDetailsAnswerDetailPage(
                                    data: list[index])))
                      },
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateAnswerListPage(context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => QaDetailsAnswerListPage()));
    //如果选择了 发布答案 显示弹窗
    if (result) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '答案已公布',
                      style: textStyle(color: Color(0xff1890ff), size: 14),
                    ),
                    Icon(
                      Icons.panorama_fish_eye,
                      size: 16,
                      color: Color(0xffbfbfbf),
                    ),
                  ],
                ),
                content: Text(
                  '报酬已按比例分配给参与者',
                  style: textStyle(color: Color(0xff8c8c8c), size: 12),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('返回首页',
                        style: textStyle(color: Color(0xff8c8c8c), size: 16)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('确认',
                        style: textStyle(
                            color: Color(0xff1890FF),
                            size: 16,
                            weight: FontWeight.w700)),
                    onPressed: () {
                      //返回ALerDiaLog

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      });
    }
    finish = result;
  }

  //参与回答的回答人列表list
  List<DetailsPublisherListItemModel> list = [
    DetailsPublisherListItemModel(
      name: '苏大',
      date: '2020-04-20  20:00',
      content: '他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案',
      type: '最佳答案',
    ),
    DetailsPublisherListItemModel(
      name: '苏东坡',
      date: '2020-04-20  20:00',
      content: '他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案',
      type: '优秀答案',
    ),
    DetailsPublisherListItemModel(
      name: '苏东坡',
      date: '2020-04-20  20:00',
      content: '他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案',
    ),
    DetailsPublisherListItemModel(
      name: '苏东坡',
      date: '2020-04-20  20:00',
      content: '他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案',
    ),
    DetailsPublisherListItemModel(
      name: '苏东坡',
      date: '2020-04-20  20:00',
      content: '他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案他的答案',
    ),
  ];
}

class DetailsPublisherListItemModel {
  //发表人名字
  final String name;
  //发表日期
  final String date;
  //发表人内容
  final String content;
  //是否是选用的答案类型
  final String type;

  DetailsPublisherListItemModel(
      {this.name, this.date, this.content, this.type});
}
