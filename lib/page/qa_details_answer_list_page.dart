import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myexercises/page/qa_details_answer_list_item_widget.dart';
import 'package:myexercises/tool/tool.dart';

///问答-详情-发布者-答案列表页面
class QaDetailsAnswerListPage extends StatefulWidget {
  @override
  _QaDetailsAnswerListPageState createState() =>
      _QaDetailsAnswerListPageState();
}

class _QaDetailsAnswerListPageState extends State<QaDetailsAnswerListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
            child: Image.asset('assets/back.png'),
            onTap: () => Navigator.maybePop(context, false)),
        title:
            Text('答案列表', style: textStyle(color: Color(0xff262626), size: 18)),
      ),
      body: ListView(
        children: <Widget>[
          ///答案列表ListView

          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => detailsAnswerListItem(index),
          ),

          ///公布结果按钮
          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: MediaQuery.of(context).size.width / 2.5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  color: Color(0xff1890FF),
                  borderRadius: BorderRadius.circular(5)),
              child:
                  Text('公布结果', style: textStyle(color: Colors.white, size: 14)),
            ),
            onTap: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        content: Text('是否公布答案?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('取消',
                                style: textStyle(
                                    color: Color(0xff8c8c8c), size: 16)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('确认',
                                style: textStyle(
                                    color: Color(0xff1890FF), size: 16)),
                            onPressed: () {
                              //返回ALerDiaLog

                              Navigator.of(context).pop();

                              // 返回上一级页面
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    });
              });
            },
          ),
        ],
      ),
    );
  }

  Widget detailsAnswerListItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: index == 0 || index == 1 ? 15 : 0),
        index == 0 || index == 1
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("${index == 0 ? '最佳答案' : '优秀答案'}",
                    style: textStyle(
                        size: 16,
                        color: Color(0xff262626),
                        weight: FontWeight.w700)),
              )
            : SizedBox(),
        SizedBox(height: 15),
        QaDetailsAnswerListItemWidget(
          widget: Icon(Icons.highlight_off, size: 16, color: Color(0xffbfbfbf)),
          adopted: false,
        ),
      ],
    );
  }
}
