import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:kitaplar/applocale.dart';
import 'package:kitaplar/utils/models/writer_detail.dart';
import 'package:kitaplar/utils/services/api_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:redacted/redacted.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    ApiService apiService = ApiService();
  
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: apiService.getComments(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                // REDACTED KULLANIMI
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0),
                  itemCount: 8,
                  itemBuilder: (context, index){
                    return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.15,
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
                var writers = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 20.0),
                  itemCount: writers.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> WriterDetailPage(writerId: writers[index].id!, app_title: writers[index].usernameTm!,)));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(writers[index].image.toString(), 
                              width: double.infinity,
                              height: screenHeight*0.15,
                              fit: BoxFit.fill,
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
                          Text(writers[index].usernameTm.toString(), style: Theme.of(context).textTheme.titleMedium,
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

class WriterDetailPage extends StatefulWidget {
  final int writerId;
  final String app_title;

  const WriterDetailPage({required this.writerId, required this.app_title});

  @override
  State<WriterDetailPage> createState() => _WriterDetailPageState();
}

class _WriterDetailPageState extends State<WriterDetailPage> {
  late Future<WriterDetail> futureDetail;

  @override
  void initState() {
    super.initState();
    futureDetail = fetchWriterDetail();
  }

  Future<WriterDetail> fetchWriterDetail() async {
    final response = await http
        .get(Uri.parse('https://kitaplar-backend.onrender.com/api/writers/${widget.writerId}/'));

    if (response.statusCode == 200) {
      return WriterDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("Detay getirilemedi");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<WriterDetail>(
          future: futureDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0),
                    itemCount: 8,
                    itemBuilder: (context, index){
                      return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: screenHeight * 0.15,
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
            } else if (snapshot.hasError) {
              return Center(child: Text("Hata: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: Text("Detay yok"));
            } else {
              var writer = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0), 
                itemCount: writer.books?.length ?? 0,
                itemBuilder: (context, index){
                  var book = writer.books?[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Pdf_acyancy(name: book?.titleTm ?? "ady", pdf: book?.file ?? "PDF yok")));
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(book?.image ?? "Image null", 
                          fit: BoxFit.fitHeight, 
                          width: double.infinity, 
                          height: screenHeight*0.15,
                          ),
                        ),
                        Text(book?.titleTm ?? "Text Null", 
                        style: Theme.of(context).textTheme.titleMedium, 
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,),
                      ],
                                        
                    ),
                  );
                  
                });
              
            }
          },
        ),
      ),
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
