import 'dart:convert';

import 'package:kitaplar/utils/constants/api_constant.dart';
import 'package:kitaplar/utils/models/comments.model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  Future<List<CommentsModel>> getComments() async{
    final response = await http.get(Uri.parse(url));

    List <CommentsModel> comments = [];
    List <dynamic> responseList = jsonDecode(response.body);
    for (var i = 0; i < responseList.length; i++) {
      comments.add(CommentsModel.fromJson(responseList[i]));
    }
    return comments;
  } 
}
