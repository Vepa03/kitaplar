import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:kitaplar/applocale.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  static  Map<String, Uri> socialLinks = {
    "Instagram": Uri.parse("https://www.instagram.com/vepa03_/"),
    "GitHub": Uri.parse("https://github.com/Vepa03"),
    "Twitter": Uri.parse("https://x.com/vepaskaa"),
    "WebSite": Uri.parse("https://babayev.vercel.app/"),
  };

  Future<void> _launchURL(BuildContext context, Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Applocale.about_us.getString(context),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              _launchURL(context, socialLinks[value]!);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Instagram",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/instagram.png", width: widthSize * 0.05),
                    SizedBox(width: widthSize * 0.05),
                    Text("Instagram"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "GitHub",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/github.png", width: widthSize * 0.05),
                    SizedBox(width: widthSize * 0.05),
                    Text("GitHub"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "Twitter",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/twitter.png", width: widthSize * 0.05),
                    SizedBox(width: widthSize * 0.05),
                    Text("Twitter"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "WebSite",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/world-wide-web.png", width: widthSize * 0.05),
                    SizedBox(width: widthSize * 0.05),
                    Text("WebSite"),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 2,
                  child: Image.asset("lib/assets/images/books.png", width: 150, height: 150),
                ),
                const SizedBox(height: 10),
                Text(
                  Applocale.title.getString(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  Applocale.biz_hakynda.getString(context),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
