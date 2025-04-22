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
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.abc),
              title: Text("data"),
            )
          ],
        ),
      ),
      body: Center(
        child: Builder(builder: (context){
          return Column(
            children: [
              Text("data"),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                print("object");
              }, child: Text("button"))
            ],
          );
        }),
      ),
    );
  }
}