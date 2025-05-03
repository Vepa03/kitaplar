class WriterDetail {
  int? id;
  String? usernameTm;
  String? image;
  List<Books>? books;

  WriterDetail({this.id, this.usernameTm, this.image, this.books});

  WriterDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usernameTm = json['username_tm'];
    image = json['image'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username_tm'] = usernameTm;
    data['image'] = image;
    if (this.books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  int? id;
  String? titleTm;
  String? image;
  int? writer;
  String? file;

  Books({this.id, this.titleTm, this.image, this.writer, this.file});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleTm = json['title_tm'];
    image = json['image'];
    writer = json['writer'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] =id;
    data['title_tm'] = titleTm;
    data['image'] = image;
    data['writer'] = writer;
    data['file'] = file;
    return data;
  }
}
