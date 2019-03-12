import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_demo/ExpenseData.dart';
// import 'login.dart';
import 'Expense_list.dart';
import 'List.dart';
import 'other_page.dart';
import 'GetApi.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class EditPage extends StatefulWidget {
  var expenseData;
  var id;

  EditPage({this.expenseData, this.id});
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {
      Navigator.of(context).pushNamed('/login');
    });
  }

  sendData() {
    final DatabaseReference database =
        FirebaseDatabase.instance.reference().child("test");
    database.push().set({
      'amount': amount.text,
      'date': _controller.text,
      'description': description.text
    });
  }

  @override
  void initState() {
    super.initState();
      amount = new TextEditingController(text: widget.expenseData.amount.toString());
 _controller = new TextEditingController(text: widget.expenseData.date.toString());
   
  }

 
  TextEditingController amount;
  TextEditingController date;

  TextEditingController description = new TextEditingController();

  GetApi ob = new GetApi();
  String mainProfilePicture =
      "https://makehimyours.com.au/wp-content/uploads/2016/11/Depositphotos_9830876_l-2015Optimised.jpg";
  String otherProfilePicture =
      "https://intlwomensclinic.com/wp-content/uploads/2017/10/older-asian.jpg";
  void switchUser() {
    String backupString = mainProfilePicture;
    this.setState(() {
      mainProfilePicture = otherProfilePicture;
      otherProfilePicture = backupString;
    });
  }


  final formKey = new GlobalKey<FormState>();
  void validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
        print(amount.text);
      print(_controller.text);
    } else {
      print('Form is invalid');
    }
  }
TextEditingController _controller;
 // final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Homepage",
          ),
          backgroundColor: Colors.indigo,
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Anjali Patidar"),
                accountEmail: new Text("Test123@.gmail.com"),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(mainProfilePicture),
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  new GestureDetector(
                    onTap: () => switchUser(),
                    child: new CircleAvatar(
                      backgroundImage: new NetworkImage(otherProfilePicture),
                    ),
                  )
                ],
              ),
              new ListTile(
                  title: new Text("First Page"),
                  trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new OtherPage("Expenses")));
                  }),
              new ListTile(
                  title: new Text("Second Page"),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new OtherPage("Second Page")));
                  }),
              new ListTile(
                  title: new Text("Expense List"),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new ExpenseList()));
                  }),
              new ListTile(
                  title: new Text("List Page"),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new Listpage()));
                  }),
              new Divider(),
              new ListTile(
                title: new Text("Close"),
                trailing: new Icon(Icons.cancel),
                onTap: () => Navigator.of(context).pop(),
              ),
              new ListTile(
                title: new Text("signout"),
                trailing: new Icon(Icons.cancel),
                onTap: _signOut,
              ),
            ],
          ),
        ),
        body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
            key: formKey,
            autovalidate: true,
            child: new ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 30.0),
                children: <Widget>[
                  // new Text(
                  //   textValue,
                  // ),
                  new TextFormField(
                    
                     
                    decoration: new InputDecoration(
                        icon: new IconButton(
                          icon: new Icon(Icons.note, color: Colors.grey),
                        ),
                        hintText: 'Enter your amount',
                        labelText: 'Amount'),
                    controller: amount,
                  ),

                               new Text(widget.id.toString()),
                  new TextFormField(
                    decoration: new InputDecoration(
                      icon: new IconButton(
                        icon:
                            new Icon(Icons.calendar_today, color: Colors.grey),
                        tooltip: 'Choose date',
                        onPressed: (() {
                          _chooseDate(context, _controller.text);
                        }),
                      ),
                      hintText: 'Enter date ',
                      labelText: 'Date',
                    ),
                    controller: _controller,
                    keyboardType: TextInputType.datetime,
                  ),
                  // new TextFormField(
                  //   maxLines: 3,
                  //   decoration: new InputDecoration(
                  //       icon: new IconButton(
                  //         icon: new Icon(Icons.note, color: Colors.grey),
                  //       ),
                  //       hintText: 'Enter description',
                  //       labelText: 'description'),
                  //   controller: description,
                  // ),
                  SizedBox(height: 20.0),

                  
                  new RaisedButton(
                    

//  child: (widget.id != null) ? Text('Update') : Text('Add')
//               onPressed: () {
//                 if (widget.id != null) {
//                   database.child(widget.id).set({
//                     'amount': amount.text,
//                     'date' : date.text,
//                     'description': description.text
//                   }).then((_) {
//                     Navigator.pop(context);
//                   });
//                 } else {
//                   database.push().set({
//                     'amount': amount.text,
//                     'date' : date.text,
//                     'description': description.text
//                   }).then((_) {
//                     Navigator.pop(context);
//                   });
//                 }
//               },

                    color: Colors.indigo,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    //onPressed: validateAndSave,
                   onPressed: sendData,
                  ),
                ]),
          ),
        )
        );
  }
  //  updateData(selectedDoc, newValues) {
  //   FirebaseDatabase.instance
  //       reference().child("test");
      
  //   }
    // );
  }
//}
