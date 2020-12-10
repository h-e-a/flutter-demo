import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../model/netImageModel.dart';

class SwiperPage extends StatefulWidget {
  List netList;

  SwiperPage({Key key, this.netList}) : super(key: key);
  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('轮播图'),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.grey.withOpacity(0.5),
        body: Container(
          alignment: Alignment.center,
          child: Swiper(
            autoplay: true,
            scrollDirection: Axis.vertical,
            viewportFraction: 0.8, // 当前视窗展示比例 小于1可见上一个和下一个视窗
            scale: 0.8, // 两张图片之间的间隔
            itemCount: 3,
            itemBuilder: (context, index) => gridViewItem(),
            pagination: SwiperPagination(
                // 分页指示器
                alignment:
                    Alignment.bottomRight, // 位置 Alignment.bottomCenter 底部中间
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15), // 距离调整
                builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.yellow,
                  color: Colors.white30.withOpacity(0.5),
                  size: 12,
                  activeSize: 20,
                  space: 8,
                )),
          ),
        ));
  }

  Widget gridViewItem({NetImageModel item}) {
    return InkWell(
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(20),
//            image: DecorationImage(
//              image: NetworkImage('${item}'),
//              fit: BoxFit.cover,
//            ),
          ),
          child: Container(
            transform: Matrix4.rotationZ(-25),
            child: Text(
              '111',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white30.withOpacity(0.5), fontSize: 18),
            ),
          )),
    );
  }
}
