import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myexercises/model/song_list_model.dart';

class FloatingPlayerPage extends StatefulWidget {
  @override
  _FloatingPlayerPageState createState() => _FloatingPlayerPageState();
}

class _FloatingPlayerPageState extends State<FloatingPlayerPage>
    with TickerProviderStateMixin {
  AnimationController rotationController;
  //播放器
  AudioPlayer audioPlayer = AudioPlayer();

  Dio songListDio = new Dio();
  Dio songDio = new Dio();
  String url = 'https://api.imjad.cn/cloudmusic/?type=playlist&id=545471779';
  List<SongListModel> list = List();
  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotationController.reset();
      } else if (status == AnimationStatus.dismissed) {
        rotationController.forward();
      }
    });
    rotationController.forward();
    songListDioGet();
  }

  void songListDioGet() async {
    try {
      songListDio.options.connectTimeout = 10000; // 服务器链接超时，毫秒
      songListDio.options.receiveTimeout = 3000;
      Response response = await songListDio.get(url);
      if (response.statusCode == 200) {
        for (var data in response.data["playlist"]["tracks"]) {
          SongListModel songListModel = SongListModel.fromJson(data);
          list.add(songListModel);
        }
      }
    } catch (err) {
      print(err);
    }
    setState(() {});
  }

  songDioGet(songId) async {
    String url = 'https://api.imjad.cn/cloudmusic/?type=song&id=$songId';
    try {
      songDio.options.connectTimeout = 10000; // 服务器链接超时，毫秒
      songDio.options.receiveTimeout = 3000;
      Response response = await songListDio.get(url);
      if (response.statusCode == 200) {
        String songUrl = '${response.data['data'][0]["url"]}';

        play(songUrl);
        setState(() {});
      }
    } catch (err) {
      print(err);
    }
  }

  play(url) async {
    int result = await audioPlayer.play(url);
    if (result == 1) {
      // success
      print('play success');
    } else {
      print('play failed');
    }
  }

  @override
  void dispose() {
    super.dispose();
    rotationController.dispose();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 0.0,
      highlightColor: Colors.transparent,
      child: RotationTransition(
        turns: rotationController,
        alignment: Alignment.center,
        child: Opacity(
          opacity: 0.8,
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Color(0xff4a4a4a).withOpacity(0.8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              backgroundImage: NetworkImage(
                'https://b308.photo.store.qq.com/psb?/V13QrEh014JLno/RErzn2wkvksTitAGcirm.BrtCUky3wQw4AWlzJvDdYY!/m/dDQBAAAAAAAAnull&bo=QAZVCNALwA8RCTE!&rf=photolist&t=5',
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                buttonPadding: EdgeInsets.all(0),
                actionsPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                contentPadding: EdgeInsets.only(left: 8, right: 8, top: 5),
                backgroundColor: Colors.white30.withOpacity(0.7),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                content: Container(
                  height: 300,
                  child: list.length == 0
                      ? Text('暂无歌曲')
                      : ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: songItem(list[index]),
                              onTap: () {
                                songDioGet(list[index].id);
                              },
                            );
                          },
                        ),
                ),
                actions: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.stop,
                      color: Colors.red,
                    ),
                    onTap: () {
                      audioPlayer.stop();
                    },
                  ),
                ],
              );
            },
          );
        });
      },
    );
  }

  Widget songItem(SongListModel data) {
    return Container(
      color: Colors.white30.withOpacity(0.6),
      height: 50,
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: <Widget>[
          Image.network(
            '${data.al.picUrl}',
            fit: BoxFit.fill,
            width: 50,
            height: 50,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Expanded(
                  child: Text(
                    '${data.name}',
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${data.al.name}',
                    style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
