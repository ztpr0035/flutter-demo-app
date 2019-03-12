import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _name = new TextEditingController();
    final formKey = new GlobalKey<FormState>();
 void validateAndSave() {
  final form = formKey.currentState;
  if(form.validate()){
    print("form is valid");
    print(_email.text);
  }
  else{
    print("invalid form");
  }
  }
  final logo = Image.asset(
    'images/fork.png',
    width: 100.0,
    height: 100.0,
  );

  Future<void> signUp() async{
  final form = formKey.currentState;
  if(form.validate()){
    form.save();
    try {
      FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text ,password: _password.text);
      user.sendEmailVerification();
      Navigator.of(context).pushNamed('/login');
    } catch (e) {
      print(e.message);
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 100.0),
          logo,
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: new Form(
              key: formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo[900])),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                        ),
                      )),
                        style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 20.0),
                new TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo[900])),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                  ),
                    style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                new TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: 'NICK NAME',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo[900])),
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
                                 ),
                SizedBox(height: 40.0),
                new RaisedButton(
                  color: Colors.indigo,
                  child: new Text(
                    'SignUp',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: signUp,
                ),
                new RaisedButton(
                  color: Colors.indigo[300],
                  child: new Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed('/login'),
                ),
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }

 
}
