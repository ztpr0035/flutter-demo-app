import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'GetApi.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  var todo1 = {"sessionId": "", "accessToken": ""};
  // In the constructor, require a Todo
  HomePage({Key key, @required this.todo1}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  ProgressHUD _progressHUD;
  // In the constructor, require a Todo
  String pathPDF = "";
  Map data;
  List taskData;
  Future<String> GetData() async {
    _loading = false;
    // print("called");
    // _progressHUD.state.show();
    http.Response response = await http.get(
        "https://backend.cloudapps.services:7561/v1/test_db/flutterDemo",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer ' + widget.todo1['accessToken']
        });

    data = json.decode(response.body);

    // print(data['Result']);
    setState(() {
      _progressHUD.state.dismiss();
      _loading = false;
      taskData = data['Result'];
    });
    //  print(taskData);
  }

  @override
  void initState() {
    super.initState();
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.blue,
      borderRadius: 5.0,
      text: 'Loading...',
    );
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    void dismissProgressHUD() {
      setState(() {
        if (_loading) {
          _progressHUD.state.dismiss();
        } else {
               
        }
        _loading = !_loading;
      });
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Document Archief",
            // "hello",
          ),
          backgroundColor: Colors.indigo,
        ),
        body: new Stack(
          children: <Widget>[
            _progressHUD,
            ListView.builder(
              itemCount: taskData == null ? 0 : taskData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Card(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "$index " + "${taskData[index]['name']}",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                          ),
                        ),
                        // Text("hello",style:  TextStyle(color: Colors.black, fontSize: 20), ),
                      ],
                    ),
                  ),
                  // When a user taps on the ListTile, navigate to the DetailScreen.
                  // Notice that we're not only creating a DetailScreen, we're
                  // also passing the current todo through to it!
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                              obj: taskData[index],
                              sessionId: widget.todo1['sessionId'])),
                    );
                  },
                );
              },
            ),
          ],
        ));
  }
}

class DetailScreen extends StatefulWidget {
  var obj = {};
  String sessionId = "";
  //DetailScreen(this.pathPDF);
  @override
  DetailScreen({Key key, @required this.obj, @required this.sessionId})
      : super(key: key);
  _DetailScreenState createState() => new _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Declare a field that holds the Todo
  String _url = "";
  bool flag = false;
  String pathPDF = "";
  @override
  void initState() {
    super.initState();
    //  print("****************** " + widget.sessionId);
    _url = widget.obj['afbeelding_url_txt'] + "&sessionId=" + widget.sessionId;
    createFileOfPdfUrl(_url).then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
        flag = true;
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
        //   );
      });
    });
    super.initState();
  }

  Future<File> createFileOfPdfUrl(_url) async {
    final url = _url;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  // In the constructor, require a Todo

  @override
  Widget build(BuildContext context) {
    if (flag) {
      return PDFViewerScaffold(
          appBar: AppBar(
            title: Text("Document"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          path: pathPDF);
    } else {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Document",
            // "hello",
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: Text("Fetching document..."),
        ),
      );
    }
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}
