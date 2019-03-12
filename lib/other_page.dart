import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class OtherPage extends StatefulWidget {
  final String pageText;
  OtherPage(this.pageText);
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
   List data;
   Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"}
        );
     this.setState(() {
      data = jsonDecode(response.body);
     });
    print(data[1]["title"]);
   return "Success!";
  }
  @override
  void initState(){
    this.getData();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    appBar:  new AppBar(
      title: new Text('Expenses'),
       backgroundColor: Colors.indigo,
    ),
   
    body: new ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context ,int index){
        return new Card(
                    child:  new Text(data[index]["title"]),
        );
      },
    )

    // new Center(
    //   child:  new Text(
    //     pageText
    //   ),
    // ),

    );
  }
}
