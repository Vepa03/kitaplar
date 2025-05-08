class kitaplar_list {
  int? id;
  String? titleTm;
  String? image;
  int? writer;
  String? file;

  kitaplar_list({this.id, this.titleTm, this.image, this.writer, this.file});

  kitaplar_list.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleTm = json['title_tm'];
    image = json['image'];
    writer = json['writer'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_tm'] = this.titleTm;
    data['image'] = this.image;
    data['writer'] = this.writer;
    data['file'] = this.file;
    return data;
  }
}