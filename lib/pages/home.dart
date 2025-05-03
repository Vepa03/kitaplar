import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    ApiService apiService = ApiService();
  
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: apiService.getComments(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var writers = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0),
                itemCount: writers.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> WriterDetailPage(writerId: writers[index].id!)));
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Text(writers[index].usernameTm.toString()),
                            Image.network(writers[index].image.toString(), 
                              width: double.infinity,
                              height: 100,
                              fit: BoxFit.cover,),
                            SizedBox(height: 20 ,)
                          ],
                        ),
                      ),
                    ),
                  );
                });
            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          }),
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
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10), 
                itemCount: writer.books?.length ?? 0,
                itemBuilder: (context, index){
                  var book = writer.books?[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Pdf_acyancy(name: book?.titleTm ?? "ady", pdf: book?.file ?? "PDF yok")));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Text(book?.titleTm ?? "Text Null"),
                          Image.network(book?.image ?? "Image null", 
                          fit: BoxFit.cover, 
                          width: double.infinity, 
                          height: 50,
                          ),
                        ],
                    
                      ),
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
