import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width_size = MediaQuery.of(context).size.width;
    double height_size = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
        backgroundColor: Colors.amber,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width_size*0.5,
              height: height_size*0.3,
              child: Lottie.asset("lib/assets/images/kitap_animation.json")),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Paylas"),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("Biz Hakynda"),
                ),
                const Divider(color: Colors.black,),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Cykalga"),
                  onTap:(){
                    Navigator.pop(context);
                  }
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        
      ),
    );
  }
}