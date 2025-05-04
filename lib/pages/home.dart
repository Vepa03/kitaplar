import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:kitaplar/applocale.dart';
import 'package:kitaplar/utils/models/writer_detail.dart';
import 'package:kitaplar/utils/services/api_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



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
              if(snapshot.hasData){
                var writers = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0),
                  itemCount: writers.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> WriterDetailPage(writerId: writers[index].id!)));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(writers[index].image.toString(), 
                              width: double.infinity,
                              height: screenHeight*0.15,
                              fit: BoxFit.fill,),
                          ),
                          Text(writers[index].usernameTm.toString(), style: Theme.of(context).textTheme.titleMedium),
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

  const WriterDetailPage({required this.writerId});

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
        .get(Uri.parse('http://192.168.100.11:8001/api/writers/${widget.writerId}/'));

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
      appBar: AppBar(title: Text("Yazar Detayı")),
      body: FutureBuilder<WriterDetail>(
        future: futureDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Detay yok"));
          } else {
            var writer = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
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
                          fit: BoxFit.fill, 
                          width: double.infinity, 
                          height: screenHeight*0.15,
                          ),
                        ),
                        Text(book?.titleTm ?? "Text Null", style: Theme.of(context).textTheme.titleMedium),
                      ],
                                        
                    ),
                  );
                  
                }),
            );
            
          }
        },
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
