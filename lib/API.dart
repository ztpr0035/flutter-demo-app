// import 'dart:async';
// import 'dart:convert';
//  import 'package:http/http.dart' as http;
//  //import 'login.dart';
// // import 'package:flutter/services.dart';

// class API {
//  sendRequest(String uId, String pass) async {
//      print('hello');
//     Map data = {
//        'username': uId,
//        'password': pass
//     };
// print(data);
// postData();
// String url = 'http://18.224.154.163:4000/user/signup';
//  Future<Map> postData(Map data) async {
//   http.Response res = await http.post(url, body: {
//      'username': 'abcde@123',
//        'password': '123456'
//   }); // post api call
//   print(res);
//    Map data = json.decode(res.body);
//   return data;
// }

  //   var url = 'http://18.224.154.163:4000/user/signup';
  //    http.post(url, body: data,headers: {"Content-Type": "application/json"} )
  //       .then((response) {
  //     print("Response status: ${response.statusCode}");
  //     print("Response body: ${response.body}");
  //   });  
//}
//  Map data = {
//        'username': 'abcde@123',
//        'password': '123456'
//     };
// String url = 'http://18.224.154.163:4000/user/signup';

//  static Future<Map> postData() async {
//    String url = 'http://18.224.154.163:4000/user/signup';
// Map headers = {
//   'Content-type' : 'application/json', 
//   // 'Accept': 'application/json',
// };
//    print('hey');
//   http.Response res = await http.post(url, body: {
//      'username': 'abcde@123',
//        'password': '123456'
//   },headers: headers); // post api call
//   Map data = json.decode(res.body);
//   return data;
// }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:async';
class API {
  sendRequest(String uId , String pass) async {
  String url =
      'http://18.224.154.163:4000/user/signup';
  Map map = {
       'username': uId,
       'password': pass,
    // 'data': {'apikey': '12345678901234567890'},
  };
  print(await apiRequest(url, map));
}

Future<String> apiRequest(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}
 }

