import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<TestModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('这是一个页面'),
      ),
      endDrawer: Container(
          color: Colors.white,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2,
          child: Text('这个一个抽屉')),
      body: list.length == 0
          ? Center(
              child: InkWell(
                  child: Text('暂无数据,点击刷新数据'),
                  onTap: () {
                    list = [
                      TestModel(name: "小王", id: "011", count: 99),
                      TestModel(name: "小明", id: "012", count: 98),
                      TestModel(name: "小李", id: "013", count: 69),
                      TestModel(name: "小东", id: "014", count: 68),
                      TestModel(),
                    ];
                    setState(() {});
                  }))
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => listItem(list[index]),
            ),
    );
  }

  Widget listItem(TestModel data) {
    return ListTile(
      title: Text('${data.name ?? '未知姓名'}'),
      subtitle: Text('id:${data.id ?? '未知id'}'),
      trailing: Text('得分:${data.count ?? '未知得分'}'),
    );
  }
}

class TestModel {
  final String name;
  final String id;
  final int count;

  TestModel({this.name, this.id, this.count});
}
