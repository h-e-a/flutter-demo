import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobSearchPhotoAlbumPage extends StatefulWidget {
  @override
  _JobSearchPhotoAlbumPageState createState() =>
      _JobSearchPhotoAlbumPageState();
}

class _JobSearchPhotoAlbumPageState extends State<JobSearchPhotoAlbumPage>
    with TickerProviderStateMixin {
  TabController tabController;

  List itemList = [
    Icons.library_books,
    Icons.library_books,
    Icons.photo,
    Icons.play_circle_outline,
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: itemList.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            centerTitle: true,
            actions: <Widget>[
              Icon(Icons.more_horiz, color: Colors.grey[300]),
              SizedBox(width: 16)
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            expandedHeight: MediaQuery.of(context).size.height / 2.5,
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
                  color: Colors.white,
                  child: TabBar(
                    labelPadding: EdgeInsets.all(5),
                    tabs: itemList.map((item) {
                      return Icon(item);
                    }).toList(),
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor: Colors.grey[400],
                    labelColor: Color(0xffFF33CC),
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: Material(
        elevation: 0,
        color: Color(0xfff5f5f5),
        child: TabBarView(controller: tabController, children: [
          AlbumTabBarView(),
          AlbumTabBarView(),
          AlbumTabBarView(title: "相册"),
          AlbumTabBarView(title: "视频"),
        ]),
      ),
    );
  }
}

typedef TopBarOnTest = Function(dynamic data);

class SliverTopBar extends StatefulWidget {
  final TopBarOnTest topBarOnTest;

  const SliverTopBar({Key key, this.topBarOnTest}) : super(key: key);
  @override
  _SliverTopBarState createState() => _SliverTopBarState();
}

class _SliverTopBarState extends State<SliverTopBar> {
  List itemListSmall = [
    Icons.chat_bubble_outline,
    Icons.radio_button_checked,
    Icons.person_pin,
    Icons.phone_iphone,
    Icons.pages,
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets screenPadding = MediaQuery.of(context).padding;
    return Container(
      color: Colors.white,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 134,
                child: Image.network(
                  'http://p1.so.qhimgs1.com/t024b5fd8c3c4ee5c8a.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    16, screenPadding.top + 20, 16, screenPadding.bottom),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'WInnie',
                                  style:
                                      _textStyle(size: 16, color: Colors.white),
                                ),
                                Icon(
                                  Icons.pregnant_woman,
                                  size: 14,
                                  color: Color(0xffB37FEB),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              '网值ID:88888888',
                              style: _textStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 11),
                    Container(
                      height: 85,
                      width: 85,
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                          'http://p2.so.qhimgs1.com/t02768267c2c59b16e1.jpg',
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '平面模特 | 时尚达人 | 美妆博主',
                          style: _textStyle(color: Color(0xff595959)),
                        ),
                        SizedBox(width: 8),
                        Text('已认证', style: _textStyle(color: Colors.blue)),
                        SizedBox(width: 4),
                        _myIcons(
                            icon: Icons.stars, color: Colors.orange, size: 14),
                      ],
                    ),
                    SizedBox(height: 28),
                    Row(
                      children: <Widget>[
                        _myIcons(icon: Icons.location_on),
                        SizedBox(width: 8),
                        Text('广东珠海', style: _textStyle()),
                        Spacer(),
                        Row(
                          children: itemListSmall
                              .map((e) => iconSmallItem(e))
                              .toList(),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _myIcons(icon: Icons.border_color),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '暖雨晴风初破冻，柳眼眉腮，已觉春心动。酒意诗情谁与共？泪融残粉花钿重。乍试夹衫金缕缝，山枕斜欹，枕损钗头凤。独抱浓愁无好…',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: _textStyle(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget iconSmallItem(item) {
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: _myIcons(icon: item, size: 16),
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Color(
                0xffFF33CC,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
            child: Text(
              '999',
              style: _textStyle(color: Colors.white, size: 8),
            ),
          ),
        ),
      ],
    );
  }
}

class AlbumTabBarView extends StatelessWidget {
  final String title;

  const AlbumTabBarView({Key key, this.title = ''}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            children: <Widget>[
              Text(
                "${title}999",
                style: _textStyle(color: Color(0xffbfbfbf)),
              ),
              Spacer(),
              InkWell(
                child: Text(
                  '所有$title>>',
                  style: _textStyle(color: Color(0xffFF33CC)),
                ),
              )
            ],
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          shrinkWrap: true,
          itemCount: 16,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 2,
              //纵轴间距
              mainAxisSpacing: 10.0,
              //横轴间距
              crossAxisSpacing: 10.0,
              //子组件宽高长度比例
              childAspectRatio: 1.0),
          itemBuilder: (context, index) =>
              GridViewAlbumItem(index: index, title: title),
        ),
      ],
    );
  }
}

//相册的列表
class GridViewAlbumItem extends StatefulWidget {
  final int index;
  final String title;

  const GridViewAlbumItem({Key key, this.index, this.title}) : super(key: key);
  @override
  _GridViewAlbumItemState createState() => _GridViewAlbumItemState();
}

class _GridViewAlbumItemState extends State<GridViewAlbumItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'http://p5.so.qhimgs1.com/t02631906ceb588bce0.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: widget.index == 0,
              child: Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                  decoration: BoxDecoration(
                      color: Color(0xffB37FEB),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8))),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.vertical_align_top,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '置顶',
                        style: _textStyle(color: Colors.white, size: 9),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.title == "相册",
              child: Positioned(
                right: 5,
                top: 5,
                child: Icon(
                  Icons.photo,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
            Visibility(
              visible: widget.title == "视频",
              child: Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 30,
                  color: Colors.white60,
                ),
              ),
            ),
            Positioned(
              left: 5,
              bottom: 5,
              child: Text(
                'Shine',
                style: _textStyle(color: Colors.white),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.cloud_circle,
                    size: 15,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '2.7w',
                    style: _textStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print('${widget.index}');
      },
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

Icon _myIcons(
    {IconData icon = Icons.person,
    double size = 18,
    Color color = Colors.grey}) {
  return Icon(icon, size: size, color: color);
}

TextStyle _textStyle({Color color, double size = 10}) {
  return TextStyle(
      color: color != null ? color : Color(0xff595959), fontSize: size);
}
