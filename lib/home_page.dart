import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
        backgroundColor: Colors.amber,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("data"),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Paylas"),
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Cykalga"),
                  onTap:(){
                    Navigator.pop(context);
                  }
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Biz Hakynda"),
                )
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