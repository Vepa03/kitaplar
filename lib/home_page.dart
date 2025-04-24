import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitaplar/pages/about_us.dart';
import 'package:kitaplar/pages/books.dart';
import 'package:kitaplar/pages/hemmesi.dart';
import 'package:kitaplar/pages/home.dart';
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
  static const List<Widget> _widgetOption = <Widget>[
    Home(),
    Books(),
    Text("Shajyrlar",)
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
        title: Text("Kitaplar",style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Hemmesi()));
              },
              child: FaIcon(FontAwesomeIcons.listUl, color: Theme.of(context).iconTheme.color, size: 20,)),
          )
        ],
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
                    leading: Icon(Icons.share, color: Theme.of(context).iconTheme.color,),
                    title: Text("Paylas",style: Theme.of(context).textTheme.titleMedium),
                    onTap: (){
                      
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Theme.of(context).iconTheme.color,),
                    title: Text("Biz Hakynda", style: Theme.of(context).textTheme.titleMedium,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
                    },
                  ),
                  ListTile(
                    leading: Icon(ikon ? Icons.sunny : Icons.nightlight_outlined, color: Theme.of(context).iconTheme.color,),
                    title: Text(tema , style: Theme.of(context).textTheme.titleMedium),
                    onTap: (){
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      Uytget();
                      ikon_uytget();
                    },
                  ),
                  const Divider(color: Colors.black,),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Theme.of(context).iconTheme.color,),
                    title: Text("Cykalga",style: Theme.of(context).textTheme.titleMedium),
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
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house, color: Theme.of(context).iconTheme.color, size: 20,), label: ""),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.bookOpen, color: Theme.of(context).iconTheme.color,size: 20), label: ""),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.book, color: Theme.of(context).iconTheme.color,size: 20), label: "")
        ],
        currentIndex: saylanIndex,
        selectedItemColor: Colors.amber,
        onTap: _onitemTapped,
        ),
        
    );
  }
}

