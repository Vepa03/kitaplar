import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:kitaplar/applocale.dart';
import 'package:kitaplar/utils/services/books_service.dart';
import 'package:redacted/redacted.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    BooksService booksService = BooksService();
  
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: booksService.getComments(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                // REDACTED KULLANIMI
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0),
                  itemCount: 21,
                  itemBuilder: (context, index){
                    return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.075,
                            color: Colors.grey.shade300,
                          ).redacted(context: context, redact: true),
                          SizedBox(height: 10),
                          Container(
                            width: 100,
                            height: 20,
                            color: Colors.grey.shade300,
                          ).redacted(context: context, redact: true),
                          SizedBox(height: 20),
                          
                          
                        ],
                    );
                  });
                }else if(snapshot.hasData){
                var books = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0),
                  itemCount: books.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Pdf_acyancy(name: books[index].titleTm!, pdf: books[index].file!,)));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(books[index].image.toString(), 
                              width: double.infinity,
                              height: screenHeight*0.09,
                              fit: BoxFit.fitHeight,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Resim tamamen yüklenmiş hali
                                }
                                return Container(
                                  width: double.infinity,
                                  height: screenHeight * 0.09,
                                  color: Colors.grey.shade300,
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              }
                              
                              ),
                          ),
                          Text(books[index].titleTm.toString(), style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,),
                          SizedBox(height: 20 ,)
                        ],
                      ),
                    );
                  });
              }else if(snapshot.hasError){
                return Column(
                  children: [
                    Image.asset("lib/assets/images/no_wifi.png", width: screenWidth*0.8, height:screenHeight*0.4,),
                    Text(Applocale.sorry_for.getString(context),style: Theme.of(context).textTheme.titleMedium)
                  ],
                );
              }
              return const CircularProgressIndicator();
            }),
        ),
      )
    );
  }
}

class Pdf_acyancy extends StatelessWidget {
  final String name;
  final String pdf;
  const Pdf_acyancy({required this.name, required this.pdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name),),
      body: SfPdfViewer.network(pdf),
    );
  
  }
}