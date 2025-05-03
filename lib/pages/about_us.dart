import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:kitaplar/applocale.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});
  
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  void _launchURL(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(Applocale.about_us.getString(context), style: Theme.of(context).textTheme.titleLarge,),
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value){
              switch (value) {
                case "Instagram":
                  _launchURL("https://www.instagram.com/vepa03_/");
                  break;
                case "GitHub":
                  _launchURL("https://github.com/your_username");
                  break;
                case "Twitter":
                  _launchURL("https://twitter.com/your_username");
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Instagram",
                child: Text("Instagram"),
              ),
              PopupMenuItem(
                value: "GitHub",
                child: Text("GitHub"),
              ),
              PopupMenuItem(
                value: "Twitter",
                child: Text("Twitter"),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Image.asset("lib/assets/images/books.png", width: 150, height: 150,),
              ),
              Text(Applocale.title.getString(context), style: Theme.of(context).textTheme.titleLarge,),
              Text(Applocale.biz_hakynda.getString(context), style: Theme.of(context).textTheme.titleSmall,)
            ],
          ),
        ),
      ),
    );
  }
}