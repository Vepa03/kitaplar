import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:kitaplar/model/post.dart';
import 'package:kitaplar/network/network_request.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final FlutterLocalization _localization = FlutterLocalization.instance;

   List <Post> postData = [];

   @override
   void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetchPosts().then((dataFromServer){
      setState(() {
        postData = dataFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: ListView.builder(
          itemCount: postData.length,
          itemBuilder: (context, index){
            return Card(
              child: Column(
                children: [
                  Text("${postData[index].id}"),
                  Text("${postData[index].title}")
                ],
              ),
            );
          } 
        )
      )
    );
  }
}
