import 'dart:async';

import 'package:flutter/material.dart';

import 'page/job_search_photo_album_page.dart';
import 'page/marriage_entrance_status_page.dart';
import 'page/qa_details_publisher_page.dart';
import 'tool/tool.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<NetImageModel> netList = [
    NetImageModel(widget: ChatPage()),
    NetImageModel(widget: JobSearchPhotoAlbumPage()),
    NetImageModel(widget: ExpandableTextPage()),
    NetImageModel(widget: MarriageEntranceStatusPage()),
    NetImageModel(widget: ChatEntryPage()),
    NetImageModel(widget: ClockPage()),
    NetImageModel(widget: SwiperPage()),
    NetImageModel(widget: TestPage()),
    NetImageModel(widget: CartPage()),
    NetImageModel(widget: ClickTestPage()),
    NetImageModel(widget: StarPage()),
    NetImageModel(widget: QaDetailPublisherPage()),
  ];

  Dio dio = Dio();
  Dio oneDio = Dio();
  bool _loading = false;
  List<dynamic> dataList;
  OneModel oneModel = OneModel();
  bool titleHeight = false;
  Map oneData;
  var date;
  var oneDate;
  AnimationController aC;
  CurvedAnimation curve;
  @override
  void initState() {
    super.initState();
    dioGet();
    oneDioGet();
    aC = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    curve = new CurvedAnimation(parent: aC, curve: Curves.easeInCubic);
  }

  void oneDioGet() async {
    try {
      oneDio.options.connectTimeout = 10000; // 服务器链接超时，毫秒
      oneDio.options.receiveTimeout = 3000;
      //获取近十天的one List
      String url = 'http://v3.wufazhuce.com:8000/api/onelist/idlist';
      Response response = await oneDio.get(url);
      if (response.statusCode == 200) {
        String _url =
            'http://v3.wufazhuce.com:8000/api/onelist/${response.data["data"][0]}/0';
        Dio oneTodayDio = Dio();
        Response _response = await oneTodayDio.get(_url);
        if (response.statusCode == 200) {
          oneData = _response.data["data"];
          date = oneData["weather"]["date"].split("-");
          oneDate = formatDate(
            DateTime(
                int.parse(date[0]), int.parse(date[1]), int.parse(date[2])),
            [yyyy, '', M, '', dd],
          );
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<Null> dioGet() async {
    try {
      dio.options.connectTimeout = 10000; // 服务器链接超时，毫秒
      dio.options.receiveTimeout = 3000;
      String url =
          'http://shibe.online/api/shibes?count=${netList.length}&urls=true&httpsUrls=true';
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        for (var i = 0; i < netList.length; i++) {
          setState(() {
            netList[i].imageUrl = response.data[i];
          });
        }

        print('获取图片完成');
      }
    } catch (err) {
      print(err);
    }
    setState(() {
      Timer.periodic(Duration(seconds: 3), (timer) {
        setState(() {
          _loading = true;
        });
      });
      aC.forward();
    });
  }

  @override
  void dispose() {
    aC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingPlayerPage(),
        backgroundColor: Color(0xff3f3f3f),
        body: !_loading ? loadingAnimated() : pageWidget(context),
      ),
    );
  }

  ///加载动画
  Widget loadingAnimated() {
    return Center(
      child: CircleProgressBar(
        100.0,
        backgroundColor: Colors.grey,
        foreColor: Colors.blueGrey,
        startNumber: 0,
        maxNumber: 100,
        duration: 3000,
        textPercent: true,
        textStyle: _textStyle(),
      ),
    );
  }

  ///分页面
  Widget pageWidget(context) {
    EdgeInsets screenPadding = MediaQuery.of(context).padding;
    return FadeTransition(
      opacity: curve,
      child: RefreshIndicator(
        onRefresh: () => dioGet(),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
              16, screenPadding.top + 10, 16, screenPadding.bottom),
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            ///one_widget
            oneWidget(),
            SizedBox(height: 20),

            ///pages and widget
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: netList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 2,
                  //纵轴间距
                  mainAxisSpacing: 20.0,
                  //横轴间距
                  crossAxisSpacing: 10.0,
                  //子组件宽高长度比例
                  childAspectRatio: 1.0),
              itemBuilder: (context, index) => gridViewItem(netList[index]),
            ),
          ],
        ),
      ),
    );
  }

  ///one_widget
  Widget oneWidget() {
    return GestureDetector(
      child: AnimatedContainer(
        curve: Curves.easeInOutSine,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Color(0xff4a4a4a),
          borderRadius: BorderRadius.circular(20),
        ),
        height: titleHeight ? 400 : 100,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: !titleHeight ? 80 : 380,
            alignment: Alignment.center,
            child: !titleHeight
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('One', style: _textStyle(size: 30)),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'one day one sentence',
                              style: _textStyle(),
                            ),
                            TextSpan(
                              text: '...',
                              style: _textStyle(size: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${oneDate.toString().substring(7)}',
                              style: TextStyle(
                                  color: Color(0xffd9d9d9),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text:
                                  '${oneDate.toString().substring(4, 7)}.${oneDate.toString().substring(0, 4)}',
                              style: TextStyle(
                                  color: Color(0xffd9d9d9),
                                  fontSize: 11,
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                '${oneData["content_list"][0]["img_url"]}',
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(height: 8),
                      Text(
                          '${oneData["content_list"][0]["title"]} | ${oneData["content_list"][0]["pic_info"]}',
                          style: _textStyle(size: 11)),
                      SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          '${oneData["content_list"][0]["forward"]}',
                          style: _textStyle(size: 12),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${oneData["content_list"][0]["words_info"]}',
                        style: _textStyle(size: 11),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${oneData["content_list"][0]["volume"]}',
                            style: _textStyle(size: 9),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          titleHeight = !titleHeight;
        });
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        print(details.delta.dx);
      },
    );
  }

  ///gridViewItem
  Widget gridViewItem(NetImageModel item) {
    return InkWell(
      radius: 0.0,
      highlightColor: Colors.transparent,
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage('${item.imageUrl}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            transform: Matrix4.rotationZ(-25),
            child: Text(
              '${item.widget}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white30.withOpacity(0.5), fontSize: 18),
            ),
          )),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => item.widget),
        );
      },
    );
  }
}

TextStyle _textStyle({Color color, double size = 14}) {
  return TextStyle(
      color: color != null ? color : Color(0xffd9d9d9).withOpacity(0.5),
      fontSize: size);
}
