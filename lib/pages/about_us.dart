import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:kitaplar/applocale.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});
  
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
 
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(Applocale.about_us.getString(context), style: Theme.of(context).textTheme.titleLarge,),
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Image.asset("lib/assets/images/books.png", width: 150, height: 150,),
            ),
            Text(Applocale.title.getString(context), style: Theme.of(context).textTheme.titleLarge,)
          ],
        ),
      ),
    );
  }
}