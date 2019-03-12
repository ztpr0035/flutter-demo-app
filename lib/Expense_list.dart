import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_demo/Edit.dart';
import 'package:login_demo/homepage.dart';
import 'ExpenseData.dart';

class ExpenseList extends StatefulWidget {
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _id;

  List<ExpenseData> allData = [];
  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('test').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      var id = snap.key;
      allData.clear();
      for (var key in keys) {
        ExpenseData d =
            new ExpenseData(data[key]['amount'], data[key]['date'], id);
        allData.add(d);
      }
    });
    super.initState();
    setState(() {
      allData  = new List();
         print('Length : ${allData.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Food Expense'),
      ),
      body: new Container(
          child: allData.length == 0
              ? new Text('No data is available')
              : new ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      title: Text(allData[index].amount),
                      subtitle: Text(allData[index].date),
                      onTap: () => _onTapItem(context, allData[index], index),
                    );
                  },
                  itemCount: allData.length,
                )),
    );
  }

  void _onTapItem(BuildContext context, ExpenseData post, int _id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(expenseData: post, id: _id),
      ),
    );
  }

  Future<bool> deleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Are you Sure ?'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              new FlatButton(
                child: new Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }

}
