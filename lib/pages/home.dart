import 'package:flutter/material.dart';
import 'package:kitaplar/utils/services/api_service.dart';



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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Column(
                      children: [
                        Text(snapshot.data![index].usernameTm.toString()),
                        Image.network(snapshot.data![index].image.toString()),
                        SizedBox(height: 20 ,)
                      ],
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
