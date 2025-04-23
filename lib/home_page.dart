import 'package:flutter/material.dart';
import 'package:kitaplar/pages/about_us.dart';
import 'package:kitaplar/pages/hemmesi.dart';
import 'package:kitaplar/them_Provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int saylanIndex = 0;
  static const TextStyle optionalstyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOption = <Widget>[
    Text("Home", style: optionalstyle,),
    Text("Kitaplar", style: optionalstyle,),
    Text("Shajyrlar", style: optionalstyle,)
  ];

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

  void _onitemTapped(int index){
    setState(() {
      saylanIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double width_size = MediaQuery.of(context).size.width;
    double height_size = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Kitaplar"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Hemmesi()));
              },
              child: Icon(Icons.grid_view_rounded)),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
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
      body: Center(child: _widgetOption.elementAt(saylanIndex),),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Kitap"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "dewdew")
        ],
        currentIndex: saylanIndex,
        selectedItemColor: Colors.amber,
        onTap: _onitemTapped,
        ),
        
    );
  }
}

