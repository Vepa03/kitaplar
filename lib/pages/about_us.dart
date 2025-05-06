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
  final Map<String, String> socialLinks = {
  "Instagram": "https://www.instagram.com/vepa03_/",
  "GitHub": "https://github.com/your_username",
  "Twitter": "https://twitter.com/your_username",
  "WebSite": "https://babayev.vercel.app/",

};
void _launchURL(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $urlString")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    double width_size = MediaQuery.of(context).size.width;
    double height_size = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        title: Text(Applocale.about_us.getString(context), style: Theme.of(context).textTheme.titleLarge,),
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              _launchURL(socialLinks[value]!);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Instagram",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/instagram.png", width: width_size*0.05,),
                    SizedBox(width: width_size*0.05,),
                    Text("Instagram"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "GitHub",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/github.png", width: width_size*0.05,),
                    SizedBox(width: width_size*0.05,),
                    Text("GitHub"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "Twitter",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/twitter.png", width: width_size*0.05,),
                    SizedBox(width: width_size*0.05,),
                    Text("Twitter"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "WebSite",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/world-wide-web.png", width: width_size*0.05,),
                    SizedBox(width: width_size*0.05,),
                    Text("WebSite"),
                  ],
                ),
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