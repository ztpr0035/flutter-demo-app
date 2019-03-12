import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'API.dart';
import 'GetApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './homepage.dart';
import 'package:progress_hud/progress_hud.dart';

class Todo {
  final String status;
  final String sessionId;
  Todo(this.status, this.sessionId);
}
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool pressed = true;
  API obj = new API();
  GetApi ob = new GetApi();
  bool _obscureText = true;
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  Future<String> postData(String email, String pass) async {
    var data = json.encode({'username': email, 'password': pass});
     print("Response body: ${data}");
    await http
        .post(
      Uri.encodeFull('http://18.224.154.163:4000/user/login'),
      headers: {'Content-Type': 'application/json', "Accept": "application/json"},
      body: data,
    )
        .then((http.Response response) {
      if (response.statusCode == 200) {
        Navigator.of(context).pushNamed('/home');
                     } else {
        throw Exception('Failed to load');
      }
    });
    return data;
  }

  void validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      postData(_email, _password);
    } else {
      print('Form is invalid');
    }
  }

Future<void> login() async{
  // pressed =false;
  var todo2 = { "sessionId" : "", "accessToken" : "" };
  var accessToken;
  var data = json.encode({'loginName': _email, 'password': _password});
  final form = formKey.currentState;
    print("Rdata: ${data}");
  if(form.validate()){
    form.save();
    try {
        await http
        .post(
      Uri.encodeFull('https://cloudapps.services/rest/api/login?loginName=${_email}&password=${_password}&output=json'),
      headers: {'Content-Type': 'application/json'},
      body: data,
    )
        .then((http.Response response,) {
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
          todo2['sessionId'] = body['sessionId'];
          // start
                http
                  .post(
                Uri.encodeFull('https://backend.cloudapps.services:7561/v1/test_db/oauth/token'),
                headers: {},
                body: {
                    "grant_type": "password",
                    "password": _password,
                    "username": _email
                },
              )
                  .then((http.Response response,) {
                if (response.statusCode == 200) {
                    accessToken = json.decode(response.body)['Result']['access_token'];
                    todo2['accessToken'] = accessToken;
                    pressed = true;
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => HomePage(todo1 : todo2),
                          ),
                        );
                }
              });
          // end
                     } else {
        throw Exception('Failed to load');
      }
    });
    } catch (e) {
      print(e.message);
    }
  }
}
  final logo = Image.asset(
    'images/fork.png',
    width: 100.0,
    height: 100.0,
  );

  @override
  Widget build(BuildContext context) {
    // pressed = true;
    return new Scaffold(
      body: new Stack(
          children: <Widget>[
            
            // _progressHUD,
      new Container(
        padding: EdgeInsets.fromLTRB(16.0, 120.0, 16.0, 16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
             <Widget>[
             // _progressHUD,
              new TextFormField(
                keyboardType: TextInputType.emailAddress,
                // initialValue: 'abc@gmail.com',
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: new TextStyle(
                      color: Colors.grey,
                       fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                  fillColor: Colors.grey[50].withOpacity(0.6),
                  filled: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                    ), // icon is 48px widget.
                  ),
                ),
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                validator: (value) =>
                    value.isEmpty ? 'Email can\'t be empty' : null,
                onSaved: (value) => _email = value,
              ),
              SizedBox(height: 20.0),
              new TextFormField(
                obscureText: _obscureText,
                // initialValue: 'some password',
                decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: new TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ), // icon is 48px widget.
                  ),
                  fillColor: Colors.grey[50].withOpacity(0.6),
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                      // semanticLabel:
                      //     _obscureText ? 'show password' : 'hide password',
                    ),
                  ),
                ),
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                // obscureText: true,
                validator: (value) =>
                    value.isEmpty ? 'Password can\'t be empty' : null,
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 20.0),
              new RaisedButton(
                color: Colors.indigo,
                child: new Text(
                  pressed ? 'Signin' : 'Signing in...' ,
                  style: TextStyle(
                    color: Colors.white,
                    
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 //onPressed: validateAndSave,
                onPressed: ()=>{login(), setState(()=>{
                  pressed =false
                })}
                ,
              ),
              SizedBox(height: 20.0),
              // SizedBox(width: 15.0),
             
            ],
          ),
        ),
      )]
      )
    );
  }
}
