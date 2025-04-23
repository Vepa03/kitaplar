import 'package:flutter/material.dart';
import 'package:kitaplar/pages/about_us.dart';
import 'package:kitaplar/them_Provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tema = "Gije";
  bool ikon = false;

  void Uytget(){
    setState(() {
      tema = tema=="Gije" ? "Gundiz" : "Gije";
    });
  }

  void ikon_uytget(){
    setState(() {
      ikon =! ikon;
    });
  }
  
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                    onTap: (){
                      
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text("Biz Hakynda"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
                    },
                  ),
                  ListTile(
                    leading: Icon(ikon ? Icons.sunny : Icons.nightlight_outlined),
                    title: Text(tema),
                    onTap: (){
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      Uytget();
                      ikon_uytget();
                    },
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
      ),
      body: Center(
        
      ),
    );
  }
}

