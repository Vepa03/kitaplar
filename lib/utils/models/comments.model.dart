class CommentsModel {
  int? id;
  String? usernameTm;
  String? image;

  CommentsModel({this.id, this.usernameTm, this.image});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usernameTm = json['username_tm'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username_tm'] = usernameTm;
    data['image'] = image;
    return data;
  }
}