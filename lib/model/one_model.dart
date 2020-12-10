class OneModel {
  String id;
  String tag;
  String origin;
  String content;
  String datetime;

  OneModel({this.id, this.tag, this.origin, this.content, this.datetime});

  OneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
    origin = json['origin'];
    content = json['content'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    data['origin'] = this.origin;
    data['content'] = this.content;
    data['datetime'] = this.datetime;
    return data;
  }
}
