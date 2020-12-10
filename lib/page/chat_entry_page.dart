import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatEntryPage extends StatefulWidget {
  @override
  _ChatEntryPageState createState() => _ChatEntryPageState();
}

class _ChatEntryPageState extends State<ChatEntryPage>
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
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: itemList.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            actions: <Widget>[
              Icon(Icons.more_horiz, color: Colors.grey[300]),
              SizedBox(width: 16)
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            expandedHeight: MediaQuery.of(context).size.height * 0.45,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: TopTabBar(),
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
          DetailsPage(),
          LibraryPage(),
          Center(
            child: Text('哈哈哈哈'),
          ),
          Center(
            child: Text('哈哈哈哈'),
          ),
        ]),
      ),
    );
  }
}

///顶部内容
class TopTabBar extends StatefulWidget {
  @override
  _TopTabBarState createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar> {
  List itemListSmall = [
    Icons.chat_bubble_outline,
    Icons.radio_button_checked,
    Icons.person_pin,
    Icons.phone_iphone,
    Icons.pages,
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        //头像和姓名
        Container(
          height: 238,
          child: Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://ae01.alicdn.com/kf/U6b95c17854ec4b82987c7c30d405a433i.jpg'),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 76,
                      height: 76,
                      padding: EdgeInsets.all(1),
                      color: Colors.white,
                      child: Image.network(
                        'https://ae01.alicdn.com/kf/U9d94a4afa3a84a6abcadcf7b284fde50R.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Winnie',
                              style: _textStyle(
                                  color: Color(0xffFF33CC), size: 14),
                            ),
                            Icon(Icons.pregnant_woman,
                                size: 9, color: Color(0xffFF33CC)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          '网值ID88888888',
                          style: _textStyle(color: Color(0xffbfbfbf)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //个人地址及冒泡信息
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _myIcons(icon: Icons.location_on),
                  SizedBox(width: 8),
                  Text('广东珠海', style: _textStyle()),
                  Spacer(),
                  Row(
                    children:
                        itemListSmall.map((e) => iconSmallItem(e)).toList(),
                  ),
                ],
              ),
              //个人介绍
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
    );
  }

  //冒泡信息提醒
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

///个人信息页面
class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //是否支付了
  bool pay = false;
  //是否打开基本信息
  bool information = true;
  //是否打开兴趣爱好
  bool hobby = true;
  //基本信息列表数组
  List informationList = [
    {"title": "昵称", "data": "Winnie"},
    {"title": "年龄", "data": "18"},
    {"title": "生日", "data": "6/18"},
    {"title": "常驻", "data": "珠海"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: pay
          ? ListView(
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                //基本信息
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: titleRow(
                        title: '基本信息',
                        open: information,
                      ),
                      onTap: () {
                        setState(() {
                          information = !information;
                        });
                      },
                    ),
                    Visibility(
                      visible: information,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: informationList
                              .map((item) => informationItem(item))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                //兴趣爱好
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: titleRow(title: '兴趣爱好', open: hobby),
                      onTap: () {
                        setState(() {
                          hobby = !hobby;
                        });
                      },
                    ),
                    Visibility(
                      visible: hobby,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '综述',
                              style: _textStyle(
                                  color: Color(0xff262626), size: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱好综述爱。',
                              style: _textStyle(
                                  color: Color(0xffbfbfbf), size: 14),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '爱好',
                                  style: _textStyle(
                                      color: Color(0xff262626), size: 16),
                                ),
                                Text(
                                  '读书/绘画/音乐/运动',
                                  style: _textStyle(
                                      color: Color(0xffbfbfbf), size: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : unpaidWidget(),
    );
  }

  ///基本信息item
  Widget informationItem(item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: <Widget>[
          Text(
            '${item['title']}',
            style: _textStyle(color: Color(0xff262626), size: 16),
          ),
          Spacer(),
          Text(
            '${item['data']}',
            style: _textStyle(color: Color(0xffbfbfbf), size: 16),
          ),
        ],
      ),
    );
  }

  ///标题下拉组件
  Widget titleRow({String title, bool open}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Color(0xfff5f5f5),
      child: Row(
        children: <Widget>[
          Text(
            '$title',
            style: _textStyle(color: Color(0xff8c8c8c), size: 14),
          ),
          Spacer(),
          Icon(
            open ? Icons.expand_less : Icons.expand_more,
            color: Color(0xffbfbfbf),
          ),
        ],
      ),
    );
  }

  ///未付费提示
  Widget unpaidWidget() {
    return Container(
      color: Color(0xfff5f5f5),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                  color: Color(0xffFF33CC),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 27),
              child: Text(
                '详细资料，需付费查看',
                style: _textStyle(color: Colors.white, size: 16),
              ),
            ),
            onTap: () {
              setState(() {
                pay = !pay;
              });
            },
          ),
        ],
      ),
    );
  }
}

///文库页面
class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List libraryTabList = ['文章', '文集', '连载'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: libraryTabList.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          color: Colors.white,
          child: TabBar(
            labelColor: Color(0xff262626),
            unselectedLabelColor: Color(0xff8C8C8C),
            indicatorColor: Color(0xff262626),
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: libraryTabList.map((e) => Text('$e')).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              LibraryArticlePage(),
              Text('哈哈哈'),
              Text('哈哈哈'),
            ],
          ),
        ),
      ],
    );
  }
}

///文库-文章分页面
class LibraryArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          itemCount: 8,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '一剪梅·红藕香残玉簟秋',
                  style: _textStyle(color: Color(0xff262626), size: 16),
                ),
                SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Color(0xff7EBFFC))),
                      child: Text(
                        '原创',
                        style: _textStyle(
                          color: Color(0xff7EBFFC),
                        ),
                      ),
                    ),
                    SizedBox(width: 17),
                    Text(
                      '2020.04.20',
                      style: _textStyle(color: Color(0xff8c8c8c)),
                    ),
                    Spacer(),
                    rowIcon(Icons.thumb_up, '999'),
                    SizedBox(width: 19),
                    rowIcon(Icons.calendar_today, '999'),
                    SizedBox(width: 19),
                    rowIcon(Icons.share, '999'),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 14),
          alignment: Alignment.center,
          child: InkWell(
            child: Text(
              '进入作者文库>>',
              style: _textStyle(
                color: Color(0xffFF33CC),
              ),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget rowIcon(IconData iconData, String number) {
    return Row(
      children: <Widget>[
        _myIcons(
          icon: iconData,
          size: 12,
          color: Color(0xffbfbfbf),
        ),
        SizedBox(width: 4),
        Text(
          '$number',
          style: _textStyle(
            color: Color(0xffbfbfbf),
          ),
        ),
      ],
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
