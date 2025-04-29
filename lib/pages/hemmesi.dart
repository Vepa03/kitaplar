import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:kitaplar/applocale.dart';

class Hemmesi extends StatelessWidget {
  const Hemmesi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Applocale.all_books.getString(context)),
        elevation: 2,
      ),
    );
  }
}