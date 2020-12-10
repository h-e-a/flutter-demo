import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarriageEntranceStatusPage extends StatefulWidget {
  @override
  _MarriageEntranceStatusPageState createState() =>
      _MarriageEntranceStatusPageState();
}

class _MarriageEntranceStatusPageState extends State<MarriageEntranceStatusPage>
    with TickerProviderStateMixin {
  TabController controller;
  List tabName = ["文章", "文集", "连载"];
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (b, vc) {
        return [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            expandedHeight: MediaQuery.of(context).size.height / 7 * 4,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: SliverTopBar(),
            ),
            floating: false,
            pinned: true,
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: MarriageDelegate(
                  child: Material(
                child: Container(
                  height: 50,
                  child: TabBar(
                    labelPadding: EdgeInsets.all(10),
                    tabs: tabName.map((item) {
                      return Text(
                        item,
                        style: TextStyle(fontSize: 16),
                      );
                    }).toList(),
                    controller: controller,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.black,
                    unselectedLabelColor: Colors.grey[400],
                    labelColor: Colors.black,
                  ),
                ),
              ))),
        ];
      },
      body: Material(
        child: TabBarView(
            controller: controller,
            children: [
              MaeeiageTabbarView(),
              MaeeiageTabbarView(),
              MaeeiageTabbarView(),
            ]),
      ),
    );
  }
}

//上方的sliverappbar
class SliverTopBar extends StatefulWidget {
  @override
  _SliverTopBarState createState() => _SliverTopBarState();
}

class _SliverTopBarState extends State<SliverTopBar> {
  String text =
      "的法网发hi i i i i i i i i i i i i i i i i i i i i u外哦分后i发发发发发发覅oh覅返还话费hi爱发火";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          "https://img02.mockplus.cn/idoc/xd/2020-06-22/7739db52-09af-48f8-b7d0-87806c22ae4e.png",
          height: MediaQuery.of(context).size.height / 7 * 4,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
            bottom: 0,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Winnie",
                                  style: TextStyle(
                                      color: Color(
                                        0xffFF33CC,
                                      ),
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.ac_unit,
                                  size: 9,
                                  color: Color(0xffFF33CC),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "网值ID:",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                                Text(
                                  "88888888",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: <Widget>[
                            Text(
                              "44444",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "粉丝",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: <Widget>[
                            Text(
                              "44444",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "关注",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: <Widget>[
                            Text(
                              "44444",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "人气",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.ac_unit,
                              size: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "广东珠海",
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xff595959)),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 3 * 1),
                            Icon(Icons.ac_unit, size: 16),
                            Spacer(),
                            Icon(Icons.ac_unit, size: 16),
                            Spacer(),
                            Icon(Icons.ac_unit, size: 16),
                            Spacer(),
                            Icon(Icons.ac_unit, size: 16),
                            Spacer(),
                            Icon(Icons.ac_unit, size: 16),
                          ],
                        ),
                        SizedBox(height: 9),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.ac_unit,
                              size: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(text,
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff595959))),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 17),
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              Icon(
                                Icons.ac_unit,
                                size: 25,
                              ),
                              Spacer(),
                              Icon(Icons.ac_unit, size: 25),
                              Spacer(),
                              Icon(Icons.ac_unit, size: 25),
                              Spacer(),
                              Icon(Icons.ac_unit, size: 25),
                              Spacer(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class MaeeiageTabbarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return MaeeiageTabbarViewContent();
      },
      itemCount: 50,
    );
  }
}

//
class MaeeiageTabbarViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "一剪梅·红藕香残玉簟秋",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6),
                child: Text("原创",
                    style: TextStyle(fontSize: 10, color: Colors.blue)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1),
                ),
              ),
              SizedBox(width: 11),
              Text("2020.04.20",
                  style: TextStyle(fontSize: 10, color: Colors.grey[400])),
              Spacer(),
              Icon(
                Icons.ac_unit,
                size: 17,
              ),
              SizedBox(
                width: 4,
              ),
              Text("100",
                  style: TextStyle(fontSize: 10, color: Colors.grey[400])),
              SizedBox(width: 15),
              Icon(
                Icons.ac_unit,
                size: 17,
              ),
              SizedBox(
                width: 4,
              ),
              Text("100",
                  style: TextStyle(fontSize: 10, color: Colors.grey[400])),
              SizedBox(width: 15),
              Icon(
                Icons.ac_unit,
                size: 17,
              ),
              SizedBox(
                width: 4,
              ),
              Text("100",
                  style: TextStyle(fontSize: 10, color: Colors.grey[400])),
            ],
          )
        ],
      ),
    );
  }
}

//吸顶
class MarriageDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  MarriageDelegate({this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
