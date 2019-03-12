import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class Listpage extends StatefulWidget {
  _ListpageState createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  Map data;
  List taskData;
  Future<String> GetData() async{
    http.Response response = await http.post('http://18.224.154.163:4000/task/getAllTask',
     body : { 'task' : 'all'}, headers: { 'Content-Type' : 'application/x-www-form-urlencoded',
     'Authorization':'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1NDEyMzE4MTJ9.7pgyth_3_14xcd0UG8VZ7Hwpp1yKZCLqh8pl-BPJSDs'});
     print(response.body);
     data = json.decode(response.body);
    // print(data);
     setState(() {
            taskData = data["data"];
          });
    // print(taskData);

  }
  @override void initState() { 
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('list'),
    ),
    body: ListView.builder(
      itemCount: taskData == null ? 0 : taskData.length,
      itemBuilder: (BuildContext context , int index){
        return Card(
         child: Row(
           children: <Widget>[
             Text("${taskData[index]["routine_type"]}",style:  TextStyle(color: Colors.black),
                         ),
             
           ],
         ),
       );
      },
    ),
  );
  }
}