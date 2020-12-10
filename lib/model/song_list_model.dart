class SongListModel {
  String name;
  int id;
  Al al;

  SongListModel({this.name, this.id, this.al});

  SongListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    al = json['al'] != null ? new Al.fromJson(json['al']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.al != null) {
      data['al'] = this.al.toJson();
    }
    return data;
  }
}

class Al {
  int id;
  String name;
  String picUrl;
  int pic;

  Al({this.id, this.name, this.picUrl, this.pic});

  Al.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    data['pic'] = this.pic;
    return data;
  }
}
