import 'dart:convert';

import 'package:kitaplar/utils/constants/api_constant.dart';

import 'package:http/http.dart' as http;
import 'package:kitaplar/utils/models/kitaplar_list.dart';

class BooksService {
  Future<List<kitaplar_list>> getComments() async{
    final response = await http.get(Uri.parse(url_book));

    List <kitaplar_list> comments = [];
    List <dynamic> responseList = jsonDecode(response.body);
    for (var i = 0; i < responseList.length; i++) {
      comments.add(kitaplar_list.fromJson(responseList[i]));
    }
    return comments;
  } 
}
