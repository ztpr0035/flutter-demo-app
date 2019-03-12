import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetApi {
  String d;
  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});
    List data = jsonDecode(response.body.toString());
    print(data[1]["title"]);
   // return data;
  }
  Future<String> postData(String email, String pass) async {
    var data = json.encode({'username': email, 'password': pass});
    await http
        .post(
      Uri.encodeFull('http://18.224.154.163:4000/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: data,
    )
        .then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
    return data;
  }
}
