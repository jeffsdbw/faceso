import 'dart:ui' as ui;
import 'package:faceso/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Widget _buildContent(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
  /*
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildAvatar(),
        _buildInfo(context),
        _buildSignIn(),
        //Text('Status:' + s_status),
      ],
    ),
  );
  */
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  //if(record.status==1){
  return SingleChildScrollView(
    key: ValueKey(record.status),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildAvatar(),
        _buildInfo(context, record.status, record.line1, record.line2,
            record.line3, record.line4, record.server),
        //_buildSignIn(),
        //Text('Status:' + s_status),
      ],
    ),
  );
  //} else {

  //}
}

Widget _buildAvatar() {
  return Container(
    width: 165.0,
    height: 165.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white30),
    ),
    margin: const EdgeInsets.only(top: 75.0),
    padding: const EdgeInsets.all(3.0),
    child: ClipOval(
      //child: Image.asset(artist.avatar),
      child: Image(image: AssetImage('assets/images/logo6.png')),
    ),
  );
}

Widget _buildInfo(BuildContext context, String status, String line1,
    String line2, String line3, String line4, String server) {
  TextEditingController ctrUsername = TextEditingController();
  TextEditingController ctrPassword = TextEditingController();

  Future<Null> doLogin() async {
    final response = await http.post(
      server +
          'checkLogin.php?user=' +
          ctrUsername.text +
          '&password=' +
          ctrPassword.text +
          '&appid=FACESO',
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['results']['status'] == '0') {
        String userID = ctrUsername.text;
        String userName = jsonResponse['results']['name'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userID', userID);
        prefs.setString('userName', userName);
        prefs.setString('server', server);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        //print(jsonResponse['Error']);
        String vMsg = jsonResponse['results']['message'];
        showDialog<Null>(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text(
                  vMsg,
                  //style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  /*Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Please try login again!',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),*/
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: const Text('OK',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              );
            });
      }
    } else {
      showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text(
                'Connection Error!!!',
                //style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                /*Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Please try login again!',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),*/
                new SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: const Text('OK',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            );
          });
    }
  }

  void _doLogin() {
    /*print('Hello Jeffsomk !!! User is ' +
        ctrUsername.text +
        ' and Password is ' +
        ctrPassword.text);*/

    if (ctrUsername.text.isEmpty || ctrPassword.text.isEmpty) {
      showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text(
                'Please fill User ID and Password!!!',
                //style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                /*Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Please try login again!',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),*/
                new SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: const Text('OK',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            );
          });
    } else {
      doLogin();
    }

    /*
    if (ctrUsername.text == 'SOMKAMOL' && ctrPassword.text == 'Jeff') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      print('Incorrect User or Password!!!');
    }*/
  }

  if (status == "1") {
    FocusNode _userFocus = new FocusNode();
    FocusNode _passwordFocus = new FocusNode();
    return Padding(
        padding: const EdgeInsets.only(top: 80.0, left: 60.0, right: 60.0),
        child: Form(
          child: Column(children: <Widget>[
            TextFormField(
              controller: ctrUsername,
              focusNode: _userFocus,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.pinkAccent, fontSize: 25.0),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 30.0,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'User ID',
                labelStyle: new TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              onFieldSubmitted: (v) {
                _userFocus.unfocus();
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
              /*
                decoration: new InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 3.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: const BorderSide(color: Colors.blue, width: 0.0),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'User ID',
                  labelStyle: new TextStyle(color: Colors.green),
                ),
                */
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: ctrPassword,
              focusNode: _passwordFocus,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.pinkAccent, fontSize: 25.0),
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'Password',
                labelStyle: new TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            //Text('Check:' + status + ":" + line1),
            //_buildSignIn(),
            Material(
              borderRadius: BorderRadius.all(const Radius.circular(30.0)),
              shadowColor: Colors.pink[500],
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 290.0,
                height: 55.0,
                onPressed: () => _doLogin(),
                color: const Color.fromRGBO(247, 64, 106, 1.0),
                child: Text(
                  'Login',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ]),
        ));
  } else {
    return new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Text(
            line1,
            style: TextStyle(
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            line2,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w500,
              fontSize: 25.0,
            ),
          ),
          Text(
            line3,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w500,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            width: 300.0,
            height: 1.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            line4,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSignIn() {
  // TODO
  return GestureDetector(
      onTap: () {
        print('Hello Jeff!');
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        width: 240.0,
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          color: const Color.fromRGBO(247, 64, 106, 1.0),
          borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
        ),
        child: new Text(
          "Sign In",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        ),
      ));

  /*
  return new Container(
    margin: EdgeInsets.only(top: 20.0),
    width: 240.0,
    height: 50.0,
    alignment: FractionalOffset.center,
    decoration: new BoxDecoration(
      color: const Color.fromRGBO(247, 64, 106, 1.0),
      borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
    ),
    child: new Text(
      "Sign In",
      style: new TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.3,
      ),
    ),
  );*/
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('faceso').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //Image.asset(artist.backdropPhoto, fit: BoxFit.cover),
                Image(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover),
                BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                  child: Container(
                    color: Colors.black.withOpacity(0.75),
                    child: _buildContent(context, snapshot.data.documents),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class Record {
  final String status;
  final String line1;
  final String line2;
  final String line3;
  final String line4;
  final String server;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['status'] != null),
        assert(map['line1'] != null),
        assert(map['line2'] != null),
        assert(map['line3'] != null),
        assert(map['line4'] != null),
        assert(map['server'] != null),
        status = map['status'],
        line1 = map['line1'],
        line2 = map['line2'],
        line3 = map['line3'],
        line4 = map['line4'],
        server = map['server'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$status:$line1:$line2:$line3:$line4:$server>";
}
