import 'package:flutter/material.dart';
import 'login.dart';
import 'homepage.dart';
import 'Signup.dart';
import 'dart:async';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomePage(),
        '/signup': (BuildContext context) => new SignUpPage(),
             },

      // home: MyHomePage(title: 'Home'),
    //  home: SplashScreen(),
      // home :HomePage(),
      home: LoginPage(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override void initState() {
      // TODO: implement initState
      Timer(Duration(seconds: 5), () => LoginPage());
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //         title: Text(widget.title),
    //     backgroundColor: Colors.purple[800],
    //   ),

    //   body: Center(
    //         ),);
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.indigo[900]),
          // decoration: new BoxDecoration(
          //   image: new DecorationImage(
          //       image: new AssetImage('images/cafe-balck.jpg'),
          //       fit: BoxFit.cover),
          // ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 65.0,
                      child: Icon(
                        Icons.fastfood,
                        color: Colors.blue,
                        size: 68.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      "Cafeteria",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text("   Cafeteria \n for Everone",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),

            )
          ],
        )
      ],
    ));
  }
}
