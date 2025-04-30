import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:kitaplar/applocale.dart';
const Duration fakeApiDuration =Duration(seconds: 2);
class Hemmesi extends StatefulWidget {
  const Hemmesi({super.key});

  @override
  State<Hemmesi> createState() => _HemmesiState();
}

class _HemmesiState extends State<Hemmesi> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Applocale.all_books.getString(context)),
        actions: [
          birzatlar()
        ],
        elevation: 2,
      ),
      
    );
  }
}
class birzatlar extends StatefulWidget {
  const birzatlar({super.key});

  @override
  State<birzatlar> createState() => _birzatlarState();
}

class _birzatlarState extends State<birzatlar> {
  String ? _searchwithQuery;
  late Iterable<Widget> _lastoption = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller){
        return IconButton(
          onPressed: (){
            controller.openView();
          }, 
          icon: Icon(Icons.search)
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller)async{
        _searchwithQuery = controller.text;
        final List<String> options = (await FakeApi.search(_searchwithQuery!)).toList();
        if (_searchwithQuery != controller.text){
          return _lastoption;
        }
        _lastoption = List<ListTile>.generate(options.length, (int index){
          final String item = options[index];
          return ListTile(title: Text(item),);
        });
        return _lastoption;
      },
    );
  }
}
class FakeApi{
  
  static const List<String> _koption = <String>[
    "awais", 'wepa','kadyr'
  ];
  static Future<Iterable<String>> search(String query)async{
    await Future <void>.delayed(fakeApiDuration);
    if(query == ''){
      return const Iterable.empty();
    }
    return _koption.where((String options){
      return options.contains(query.toLowerCase());
    });
  }
}